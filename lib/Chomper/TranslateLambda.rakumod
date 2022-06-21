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

multi sub extract-lambda-parameter-initializer($item where Cpp::Capture::Init) {  

    my $id   = to-rust-ident($item.initcapture.identifier, snake-case => True);
    my $init = to-rust($item.initcapture.initializer);

    Rust::LetStatement.new(
        maybe-comment      => Nil,
        outer-attributes   => [],
        pattern-no-top-alt => $id,
        maybe-type         => Nil,
        maybe-expression   => $init,
    )
}

proto sub translate-lambda-expression($item) is export { * }

multi sub translate-lambda-expression($item where Cpp::LambdaExpression) {  

    debug 'translate-lambda-expression($item)';

    my @statements = to-rust($item.compound-statement).statements.List;

    my $lambda-introducer = $item.lambda-introducer;
    my $lambda-declarator = $item.lambda-declarator;

    my $parameter-declaration-clause = $lambda-declarator 
    ?? $lambda-declarator.parameter-declaration-clause
    !! Nil;

    my $lambda-capture = $lambda-introducer.lambda-capture;

    my Bool $move = False;
    my @captures = [];

    given $lambda-capture {
        when Cpp::CaptureDefault::Assign {
            $move = True;
        }
        when Cpp::LambdaCapture::List {
            given $lambda-capture.capture-list {
                when Cpp::Capture::Simple {
                    @captures = [ $lambda-capture.capture-list ];
                }
                default {
                    @captures = $lambda-capture.capture-list.captures;
                }
            }
        }
        default {

        }
    }

    my @cpp-params = $parameter-declaration-clause 
    ?? $parameter-declaration-clause.parameter-declaration-list 
    !! [];

    my @closure-parameters = @cpp-params>>.&translate-lambda-parameter;
    my @maybe-closure-param-initializers = @cpp-params>>.&extract-lambda-parameter-initializer.flat;

    for @captures -> $capture {
        given $capture {
            when Cpp::Capture::Init {
                @maybe-closure-param-initializers.push: 
                extract-lambda-parameter-initializer($capture);
            }
        }
    }

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
