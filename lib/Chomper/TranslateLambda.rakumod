use Chomper::Cpp;
use Chomper::Rust;
use Chomper::ToRust;
use Chomper::TranslateIo;
use Chomper::ToRustType;
use Chomper::ToRustIdent;
use Chomper::ToRustParams;
use Chomper::ToRustPathInExpression;

use Chomper::IsRef;
use Chomper::IsMut;

use Data::Dump::Tree;

proto sub translate-lambda-parameter($item) is export { * }

multi sub translate-lambda-parameter($item where Cpp::ParameterDeclaration) {  

    debug 'translate-lambda-parameter($item)';

    my $decl-specifier-seq 
    = $item.decl-specifier-seq;

    # does this need to be wrapped?
    my $rust-type = to-rust-type($decl-specifier-seq); 

    my $ref = is-ref($item.parameter-declaration-body);
    my $mut = is-mut($decl-specifier-seq);

    if $ref {
        $rust-type = Rust::ReferenceType.new(
            mutable        => $mut,
            type-no-bounds => $rust-type,
        );
    }

    my $ident = to-rust-ident($item.parameter-declaration-body);

    my $maybe-initializer = extract-lambda-parameter-initializer($item);

    if $maybe-initializer {
        $rust-type = Rust::TypePathSegment.new(
            path-ident-segment => Rust::Identifier.new(
                value => "Option",
            ),
            maybe-type-path-segment-suffix => Rust::TypePathSegmentSuffixGeneric.new(
                generic-args => Rust::GenericArgs.new(
                    args => [
                        $rust-type
                    ]
                )
            )
        );
    }

    my $pattern = Rust::IdentifierPattern.new(
        ref        => False,
        mutable    => False,
        identifier => $ident,
    );

    Rust::ClosureParam.new(
        outer-attributes => [],
        pattern          => $pattern,
        maybe-type       => $rust-type,
    )
}

proto sub extract-lambda-parameter-initializer($item) is export { * }

multi sub extract-lambda-parameter-initializer($item where Cpp::ParameterDeclaration) {  

    debug 'extract-lambda-parameter-initializer($item)';

    my $ident = to-rust-ident($item.parameter-declaration-body);

    my $maybe-initializer 
    = $item.initializer-clause 
    ?? to-rust($item.initializer-clause) 
    !! Nil;

    if $maybe-initializer {

        my $unwrap-or = Rust::PathExprSegment.new(
            path-ident-segment => Rust::Identifier.new(
                value => "unwrap_or",
            )
        );

        my $unwrap-or-set = Rust::SuffixedExpression.new(
            base-expression            => $ident,
            suffixed-expression-suffix => [
                Rust::MethodCallExpressionSuffix.new(
                    path-expr-segment => $unwrap-or,
                    maybe-call-params => [
                        Rust::SuffixedExpression.new(
                            base-expression => Rust::BaseExpression.new(
                                outer-attributes => [],
                                expression-item => $maybe-initializer,
                            )
                        )
                    ],
                )
            ],
        );

        return Rust::LetStatement.new(
            maybe-comment      => Nil,
            outer-attributes   => [],
            pattern-no-top-alt => $ident,
            maybe-type         => Nil,
            maybe-expression   => $unwrap-or-set,
        );
    }
}

proto sub translate-lambda-expression($item) is export { * }

multi sub translate-lambda-expression($item where Cpp::LambdaExpression) {  

    debug 'translate-lambda-expression($item)';

    my @statements = to-rust($item.compound-statement).statements.List;

    my $lambda-introducer = $item.lambda-introducer;
    my $lambda-declarator = $item.lambda-declarator;

    my Bool $move = $lambda-introducer.lambda-capture ~~ Cpp::CaptureDefault::Assign;

    my @cpp-params = $lambda-declarator
        .parameter-declaration-clause
        .parameter-declaration-list;

    my @closure-parameters = @cpp-params>>.&translate-lambda-parameter;
    my @maybe-closure-param-initializers = @cpp-params>>.&extract-lambda-parameter-initializer.flat;

    my $closure-body = Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            outer-attributes => [],
            expression-item  => Rust::BlockExpression.new(
                inner-attributes => [],
                statements       => Rust::Statements.new(
                    statements => [|@maybe-closure-param-initializers, |@statements]
                ),
            ),
        ),
        suffixed-expression-suffix => [],
    );

    my $closure-expression = Rust::ClosureExpression.new(
        move             => $move,
        maybe-parameters => @closure-parameters,
        body             => $closure-body,
    );

    Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            outer-attributes => [],
            expression-item  => $closure-expression,
        ),
        suffixed-expression-suffix => [],
    )
}
