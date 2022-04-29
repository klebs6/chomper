use Chomper::Cpp;
use Chomper::Rust;
use Chomper::SnakeCase;
use Chomper::ToRust;
use Chomper::TranslateIo;
use Chomper::ToRustType;
use Chomper::ToRustIdent;
use Chomper::ToRustParams;
use Chomper::ToRustPathInExpression;

use Chomper::TranslateConditionalExpression;
use Chomper::TranslateExpression;
use Chomper::TranslateIndexExpressionSuffix;
use Chomper::TranslateSuffixedExpression;
use Chomper::TranslateNoPointerDeclarator;

use Data::Dump::Tree;

proto sub translate-basic-declaration-to-rust(
    Str $mask,
    $item where Cpp::BasicDeclaration) is export { * }

multi sub translate-basic-declaration-to-rust(
    Str $mask,
    $item where Cpp::BasicDeclaration) 
{
    die "need write hook for mask! $mask";
}

multi sub translate-basic-declaration-to-rust(
     "I I = T(Es);",
    $item where Cpp::BasicDeclaration:D) 
{
    debug "mask I I = T(Es);";
}

multi sub translate-basic-declaration-to-rust(
     "I = L;",
    $item where Cpp::BasicDeclaration:D) 
{
    debug "mask I = L;";
    ddt $item;
    exit;
}

multi sub translate-basic-declaration-to-rust(
     "I[N] = N * N * N;",
    $item where Cpp::BasicDeclaration:D) 
{
    debug "mask I[N] = N * N * N;";

    my $lhs = to-rust($item.init-declarator-list[0].declarator);

    my Cpp::MultiplicativeExpression $multiplicative-expr 
    = $item.init-declarator-list[0].initializer.brace-or-equal-initializer.initializer-clause;

    my @pointer-member-expressions = [
        $multiplicative-expr.pointer-member-expression,
        |$multiplicative-expr.multiplicative-expression-tail>>.pointer-member-expression
    ];

    my @expression-items = @pointer-member-expressions>>.&to-rust;

    my $rhs = Rust::MultiplicativeExpression.new(
        division-expressions => [
            Rust::SuffixedExpression.new(
                base-expression => Rust::BaseExpression.new(
                    outer-attributes => [],
                    expression-item => @expression-items[0],
                ),
                suffixed-expression-suffix => [],
            ),
            Rust::SuffixedExpression.new(
                base-expression => Rust::BaseExpression.new(
                    outer-attributes => [],
                    expression-item => @expression-items[1],
                ),
                suffixed-expression-suffix => [],
            ),
            Rust::SuffixedExpression.new(
                base-expression => Rust::BaseExpression.new(
                    outer-attributes => [],
                    expression-item => @expression-items[2],
                ),
                suffixed-expression-suffix => [],
            ),
        ]
    );

    Rust::ExpressionStatementNoBlock.new(
        maybe-comment      => Nil,
        expression-noblock => Rust::AssignExpression.new(
            addeq-expressions => [
                $lhs,
                $rhs
            ]
        )
    ).gist
}

multi sub translate-basic-declaration-to-rust(
     "T I(P);",
    $item where Cpp::BasicDeclaration:D) 
{
    debug "mask T I(P);";
    my $type = to-rust-type($item.decl-specifier-seq);
    my $name = to-rust-ident($item.init-declarator-list[0].no-pointer-declarator-base);
    my $params = to-rust-params($item.init-declarator-list[0].no-pointer-declarator-tail[0]);
    ddt %(
        :$type,
        :$name,
        :$params,
        :$item,
    );
    exit;
}

multi sub translate-basic-declaration-to-rust(
    "T I;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T I;";

    my $rust-type  = to-rust($item.decl-specifier-seq);
    my $rust-ident = to-rust-ident($item.init-declarator-list[0]);

    Rust::LetStatement.new(
        pattern-no-top-alt => Rust::IdentifierPattern.new(
            ref        => False,
            mutable    => True,
            identifier => $rust-ident,
        ),
        maybe-type       => $rust-type,
        maybe-expression => Nil,
    ).gist
}


multi sub translate-basic-declaration-to-rust(
    "I(Es);",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask I(Es);";

    my $rust-ident = 
    to-rust-ident($item.init-declarator-list[0].declarator).gist;

    my $expression-list = $item.init-declarator-list[0]
    .initializer
    .expression-list;

    my $rust-params = to-rust-params($expression-list)>>.gist.join(", ");

    if $rust-ident ~~ $all-caps {

        #consider all caps function call as
        #actaully a macro invocation.
        #
        #this isnt the case in all circumstances
        #of course, but it is usually a pretty
        #safe bet
        "{snake-case($rust-ident.lc)}!({$rust-params});"

    } else {
        "{snake-case($rust-ident)}({$rust-params});"
    }
}

multi sub translate-basic-declaration-to-rust(
    "I (I);",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask I (I);";
}

multi sub translate-basic-declaration-to-rust(
    "T I = E;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T I = E;";

    my $idl = $item.init-declarator-list[0];

    my $declarator 
    = $idl.declarator;

    my $initializer
    = $idl.initializer;

    my $decl-specifier-seq 
    = $item.decl-specifier-seq;

    my $rust-ident = to-rust-ident($declarator);
    my $rust-type  = to-rust-type($decl-specifier-seq);

    my $rust-expr  
    = to-rust($initializer.brace-or-equal-initializer.initializer-clause);

    Rust::LetStatement.new(
        pattern-no-top-alt => $rust-ident,
        maybe-type         => $rust-type,
        maybe-expression   => $rust-expr,
    ).gist
}

multi sub translate-basic-declaration-to-rust(
    "T *I = E;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T *I = E;";
    ddt $item;

    my Bool $do-type-deduction 
    = $item.decl-specifier-seq.value ~~ Cpp::SimpleTypeSpecifier::Auto_;

    my $idl = $item.init-declarator-list[0];

    my $declarator 
    = $idl.declarator;

    my $initializer
    = $idl.initializer;

    my $rust-ident = to-rust-ident($declarator.no-pointer-declarator);

    my $rust-expr  
    = to-rust($initializer.brace-or-equal-initializer.initializer-clause);

    my $rust-let-stmt = do if $do-type-deduction {

        debug "do type deduction";

        Rust::LetStatement.new(
            pattern-no-top-alt => $rust-ident,
            maybe-type         => Nil,
            maybe-expression   => $rust-expr,
        )

    } else {

        debug "no type deduction";

        my $decl-specifier-seq 
        = $item.decl-specifier-seq;

        my $rust-type  = to-rust-type($decl-specifier-seq);

        Rust::LetStatement.new(
            pattern-no-top-alt => $rust-ident,
            maybe-type         => Rust::RawPtrType.new(
                mutable        => True,
                type-no-bounds => $rust-type,
            ),
            maybe-expression   => $rust-expr,
        )
    };

    $rust-let-stmt.gist
}

multi sub translate-basic-declaration-to-rust(
    "I[N] = N;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask I[N] = N;";

    my $lhs = $item.init-declarator-list[0]
    .declarator;

    my $rhs = $item.init-declarator-list[0]
    .initializer
    .brace-or-equal-initializer
    .initializer-clause;

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => Rust::AssignExpression.new(
            addeq-expressions => [
                to-rust-suffixed-expression($lhs),
                to-rust-suffixed-expression($rhs),
            ]
        )
    ).gist
}

our class RustBasicCreationEvent {
    has $.rust-ident  is required;
    has $.rust-type   is required;
    has $.rust-params is required;

    method gist {

        my @params = $.rust-params.List;
        my $params = @params>>.gist.join(", ");
        my $ident  = $.rust-ident.gist;
        my $type   = $.rust-type.gist;

        if $.rust-type.gist ~~ /^^ Vec/ {

            if @params.elems eq 1 {

                qq:to/END/
                let $ident: $type = {$type}::with_capacity($params);
                END

            } else {
                qq:to/END/
                let $ident: $type = {$type}::new($params);
                END
            }

        } else {
            qq:to/END/
            let $ident: $type = {$type}::new($params);
            END
        }
    }
}

multi sub translate-basic-declaration-to-rust(
    "T I(Es);",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T I(Es);";

    my $rust-type   = to-rust-type($item.decl-specifier-seq);
    my $declarator0 = $item.init-declarator-list[0];

    do given $declarator0 {
        when Cpp::InitDeclarator {
            my $rust-ident  = to-rust-ident($declarator0.declarator);
            my $rust-params = to-rust-params($declarator0.initializer);

            RustBasicCreationEvent.new(
                :$rust-ident,
                :$rust-type,
                :$rust-params,
            ).gist
        }
        default {
            die "need implement for {$declarator0.WHAT.^name}";
        }
    }
}

multi sub translate-basic-declaration-to-rust(
    "T I(P, P);",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T I(P, P);";

    my $rust-type   = to-rust-type($item.decl-specifier-seq);
    my $declarator0 = $item.init-declarator-list[0];

    do given $declarator0 {

        when Cpp::NoPointerDeclarator {
            my $rust-ident  = to-rust-ident($declarator0.no-pointer-declarator-base);
            my $rust-params = to-rust-params($declarator0.no-pointer-declarator-tail[0]);

            RustBasicCreationEvent.new(
                :$rust-ident,
                :$rust-type,
                :$rust-params,
            ).gist
        }
        default {
            die "need implement for {$declarator0.WHAT.^name}";
        }
    }
}

multi sub translate-basic-declaration-to-rust(
    "I = E;",
    $item where Cpp::BasicDeclaration) 
{
    my $rust-ident = to-rust-ident($item.init-declarator-list[0].declarator);
    my $rust-rhs   = to-rust($item.init-declarator-list[0].initializer.brace-or-equal-initializer.initializer-clause);

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => Rust::AssignExpression.new(
            addeq-expressions => [
                $rust-ident,
                $rust-rhs,
            ]
        )
    ).gist
}

sub emit-basic-let-statement($item where Cpp::BasicDeclaration) {

    my $rust-type  = to-rust-type($item.decl-specifier-seq);
    my $rust-ident = to-rust-ident($item.init-declarator-list[0].declarator);
    my $rust-rhs   = to-rust($item.init-declarator-list[0].initializer.brace-or-equal-initializer.initializer-clause);

    Rust::LetStatement.new(
        pattern-no-top-alt => Rust::IdentifierPattern.new(
            ref        => False,
            mutable    => True,
            identifier => $rust-ident,
        ),
        maybe-type => Rust::TypePath.new(
            type-path-segments => [
                Rust::TypePathSegment.new(
                    path-ident-segment => $rust-type
                ),
            ],
        ),
        maybe-expression => $rust-rhs
    ).gist
}

multi sub translate-basic-declaration-to-rust(
    "T I = E * N / N + N;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T I = E * N / N + N; ";

    emit-basic-let-statement($item)
}

multi sub translate-basic-declaration-to-rust(
    "T I = N;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T I = N;";

    emit-basic-let-statement($item)
}

multi sub translate-basic-declaration-to-rust(
    "T *I = & E;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T *I = & E;";
    #ddt $item;

    my $rust-type = Rust::RawPtrType.new(
        mutable        => $item.decl-specifier-seq.is-mutable(),
        type-no-bounds => to-rust-type($item.decl-specifier-seq),
    );

    my $rust-expr 
    = to-rust(
        $item.init-declarator-list[0].initializer.brace-or-equal-initializer.initializer-clause.unary-expression
    );

    my $rust-ident 
    = to-rust(
        $item.init-declarator-list[0].declarator.no-pointer-declarator
    );

    my $rust-lhs = Rust::BorrowExpression.new(
        borrow-expression-prefixes => [
            Rust::BorrowExpressionPrefix.new(
                borrow-count => 1,
                mutable      => False,
            )
        ],
        unary-expression => $rust-expr,
    );

    Rust::LetStatement.new(
        pattern-no-top-alt => Rust::IdentifierPattern.new(
            ref     => False,
            mutable => False,
            identifier => Rust::Identifier.new(
                value => $rust-ident,
            ),
        ),
        maybe-type       => $rust-type,
        maybe-expression => $rust-lhs,
    )
}
