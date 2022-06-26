use Chomper::Cpp;
use Chomper::Rust;
use Chomper::SnakeCase;
use Chomper::ToRust;
use Chomper::IsConst;
use Chomper::IsRef;
use Chomper::TranslateIo;
use Chomper::ToRustType;
use Chomper::TokenTree;
use Chomper::LazyStatic;
use Chomper::ToRustIdent;
use Chomper::ToRustParams;
use Chomper::ToRustPathInExpression;
use Chomper::DefaultInitializer;

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
    ddt $item;
    exit;
}

multi sub translate-basic-declaration-to-rust(
     "T I, I;",
    $item where Cpp::BasicDeclaration:D) 
{
    debug "mask T I, I;";

    my $rust-type = to-rust-type($item.decl-specifier-seq);
    my $id0 = to-rust-ident($item.init-declarator-list[0]);
    my $id1 = to-rust-ident($item.init-declarator-list[1]);

    my $default-initializer = create-default-initializer($rust-type);

    Rust::Statements.new(
        statements => [
            Rust::LetStatement.new(
                pattern-no-top-alt => Rust::IdentifierPattern.new(
                    ref        => False,
                    mutable    => True,
                    identifier => $id0,
                ),
                maybe-type       => $rust-type,
                maybe-expression => $default-initializer,
            ),
            Rust::LetStatement.new(
                pattern-no-top-alt => Rust::IdentifierPattern.new(
                    ref        => False,
                    mutable    => True,
                    identifier => $id1,
                ),
                maybe-type       => $rust-type,
                maybe-expression => $default-initializer,
            ),
        ]
    )
}

multi sub translate-basic-declaration-to-rust(
     "T I, I, I;",
    $item where Cpp::BasicDeclaration:D) 
{
    debug "mask T I, I;";

    my $rust-type = to-rust-type($item.decl-specifier-seq);
    my $id0 = to-rust-ident($item.init-declarator-list[0]);
    my $id1 = to-rust-ident($item.init-declarator-list[1]);
    my $id2 = to-rust-ident($item.init-declarator-list[2]);

    my $default-initializer = create-default-initializer($rust-type);

    Rust::Statements.new(
        statements => [
            Rust::LetStatement.new(
                pattern-no-top-alt => Rust::IdentifierPattern.new(
                    ref        => False,
                    mutable    => True,
                    identifier => $id0,
                ),
                maybe-type       => $rust-type,
                maybe-expression => $default-initializer,
            ),
            Rust::LetStatement.new(
                pattern-no-top-alt => Rust::IdentifierPattern.new(
                    ref        => False,
                    mutable    => True,
                    identifier => $id1,
                ),
                maybe-type       => $rust-type,
                maybe-expression => $default-initializer,
            ),
            Rust::LetStatement.new(
                pattern-no-top-alt => Rust::IdentifierPattern.new(
                    ref        => False,
                    mutable    => True,
                    identifier => $id2,
                ),
                maybe-type       => $rust-type,
                maybe-expression => $default-initializer,
            ),
        ]
    )
}

multi sub translate-basic-declaration-to-rust(
     "I = T(Es);",
    $item where Cpp::BasicDeclaration:D) 
{
    debug "mask I = T(Es);";

    my $lhs = to-rust($item.init-declarator-list[0].declarator);

    my $rhs = to-rust(
        $item.init-declarator-list[0]
        .initializer
        .brace-or-equal-initializer
        .initializer-clause
    );

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => Rust::AssignExpression.new(
            addeq-expressions => [
                $lhs,
                $rhs,
            ]
        )
    )
}

multi sub translate-basic-declaration-to-rust(
     "T I[I];",
    $item where Cpp::BasicDeclaration:D) 
{
    translate-basic-declaration-to-rust("T I[N];", $item)
}

multi sub translate-basic-declaration-to-rust(
     "T I[N];",
    $item where Cpp::BasicDeclaration:D) 
{
    debug "mask T I[N];";

    my $idl = $item.init-declarator-list[0];

    my $rust-type   
    = to-rust-type($item.decl-specifier-seq);

    my $rust-ident  
    = to-rust-ident($idl.no-pointer-declarator-base, snake-case => True);

    my $array-count 
    = to-rust($idl.no-pointer-declarator-tail[0].constant-expression);

    my $array-type = Rust::ArrayType.new(
        type => $rust-type,
        expression => Rust::SuffixedExpression.new(
            base-expression => Rust::BaseExpression.new(
                expression-item => $array-count,
            )
        )
    );

    my $default-initializer = create-default-initializer($rust-type);

    Rust::LetStatement.new(
        pattern-no-top-alt => Rust::IdentifierPattern.new(
            ref        => False,
            mutable    => True,
            identifier => $rust-ident,
        ),
        maybe-type       => $array-type,
        maybe-expression => $default-initializer,
    )
}

multi sub translate-basic-declaration-to-rust(
     "I = * E;",
    $item where Cpp::BasicDeclaration:D) 
{
    debug "mask I = * E;";
    die "check this dispatch";

    my $lhs = to-rust($item.init-declarator-list[0].declarator);

    my $rhs = to-rust(
        $item.init-declarator-list[0]
        .initializer
        .brace-or-equal-initializer
        .initializer-clause
    );

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => Rust::AssignExpression.new(
            addeq-expressions => [
                $lhs,
                $rhs,
            ]
        )
    )
}

multi sub translate-basic-declaration-to-rust(
     'T &I(E);',
    $item where Cpp::BasicDeclaration:D) 
{
    debug 'mask T &I(E);';

    my $mask = 'T &I(E);';

    translate-standard-type-declarator($mask, $item)
}

multi sub translate-basic-declaration-to-rust(
     "T &I = E;",
    $item where Cpp::BasicDeclaration:D) 
{
    debug "mask T &I = E;";

    my $idl = $item.init-declarator-list[0];

    my $declarator 
    = $idl.declarator;

    my $initializer
    = $idl.initializer;

    my $decl-specifier-seq 
    = $item.decl-specifier-seq;

    my $is-const-type = is-const-type($decl-specifier-seq);

    my $rust-ident 
    = to-rust-ident($declarator.no-pointer-declarator, snake-case => True);

    #this is the big difference from T I = E;
    my $rust-type  = Rust::ReferenceType.new(
        mutable        => not $is-const-type,
        type-no-bounds => to-rust-type($decl-specifier-seq),
    );

    my $rust-expr  
    = to-rust($initializer.brace-or-equal-initializer.initializer-clause);

    Rust::LetStatement.new(
        pattern-no-top-alt => $rust-ident,
        maybe-type         => $rust-type,
        maybe-expression   => $rust-expr,
    )
}

multi sub translate-basic-declaration-to-rust(
     "I = L;",
    $item where Cpp::BasicDeclaration:D) 
{
    die "check this dispatch";

    my $lhs 
    = to-rust(
        $item.init-declarator-list[0].declarator
    );

    my $rhs 
    = to-rust(
        $item.init-declarator-list[0].initializer.brace-or-equal-initializer.initializer-clause
    );

    Rust::ExpressionStatementNoBlock.new(
        maybe-comment      => Nil,
        expression-noblock => Rust::AssignExpression.new(
            addeq-expressions => [
                $lhs,
                $rhs
            ]
        )
    )
}

multi sub translate-basic-declaration-to-rust(
     "I[N] = N * N * N;",
    $item where Cpp::BasicDeclaration:D) 
{
    debug "mask I[N] = N * N * N;";

    die "check this dispatch";

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
    )
}

multi sub translate-basic-declaration-to-rust(
     "T I(P);",
    $item where Cpp::BasicDeclaration:D) 
{
    debug "mask T I(P);";

    my $rust-type   = to-rust-type($item.decl-specifier-seq);
    my $rust-ident  = to-rust-ident($item.init-declarator-list[0].no-pointer-declarator-base, snake-case => True);
    my $rust-params = to-rust-params($item.init-declarator-list[0].no-pointer-declarator-tail[0]);

    my $rust-initializer = create-type-initializer($rust-type,$rust-params);

    Rust::LetStatement.new(
        pattern-no-top-alt => Rust::IdentifierPattern.new(
            ref        => False,
            mutable    => True,
            identifier => $rust-ident,
        ),
        maybe-type       => $rust-type,
        maybe-expression => $rust-initializer,
    )
}

sub create-type-initializer($rust-type,$rust-params) 
{
    if not $rust-type {
        return $rust-params;
    }

    my $initializer-name = "new";

    Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::PathExprSegment.new(
                        path-ident-segment => $rust-type,
                    ),
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => $initializer-name
                        )
                    ),
                ],
            )
        ),
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => $rust-params,
            )
        ],
    ).gist
}

multi sub translate-basic-declaration-to-rust(
    "static T I = E;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask static T I = E;";
    my $type-specifier  = $item.decl-specifier-seq.decl-specifiers[1];
    my $init-declarator = $item.init-declarator-list[0].declarator;
    my $initializer     = $item.init-declarator-list[0].initializer;

    my $rust-type        = to-rust-type($type-specifier);
    my $rust-ident       = to-rust-ident($init-declarator);
    my $rust-initializer = to-rust($initializer.brace-or-equal-initializer);

    create-lazy-static($rust-type,$rust-ident,$rust-initializer)
}

multi sub translate-basic-declaration-to-rust(
    "static T I;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask static T I;";

    my $type-specifier  = $item.decl-specifier-seq.decl-specifiers[1];
    my $init-declarator = $item.init-declarator-list[0];

    my $rust-type           = to-rust-type($type-specifier);
    my $rust-ident          = to-rust-ident($init-declarator);
    my $default-initializer = create-default-initializer($rust-type);

    create-lazy-static($rust-type,$rust-ident,$default-initializer)
}

multi sub translate-basic-declaration-to-rust(
    "typedef T I;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask typedef T I;";

    my $type-specifier  = $item.decl-specifier-seq.decl-specifiers[1];
    my $init-declarator = $item.init-declarator-list[0];

    my $rust-type           = to-rust-type($type-specifier);
    my $rust-ident          = to-rust-ident($init-declarator);

    create-rust-typedef($rust-type,$rust-ident)
}

our sub create-rust-typedef($rust-type,$rust-ident) {

    my $type-alias = Rust::TypeAlias.new(
        identifier    => $rust-ident,
        maybe-eq-type => $rust-type,
    );

    my $vis-item = Rust::VisItem.new(
        maybe-visibility => Rust::VisibilityPublic.new,
        vis-item-variant => $type-alias,
    );

    Rust::CrateItem.new(
        item-variant => $vis-item
    )
}

multi sub translate-basic-declaration-to-rust(
    'static T I{E};',
    $item where Cpp::BasicDeclaration) 
{
    debug 'mask static T I{E};';

    debug 'mask T I{E};';

    my $idl = $item.init-declarator-list[0];

    my $declarator 
    = $idl.declarator;

    my $initializer
    = $idl.initializer;

    my $decl-specifier-seq 
    = $item.decl-specifier-seq;

    my $rust-ident = to-rust-ident($declarator, snake-case => True);
    my $rust-type  = to-rust-type($decl-specifier-seq);

    my $rust-params  
    = to-rust-params($initializer.brace-or-equal-initializer);

    my $type-initializer = create-type-initializer($rust-type,$rust-params);

    if is-const-type($decl-specifier-seq.decl-specifiers) {

        create-pub-const($rust-type,$rust-ident,$type-initializer)

    } else {

        create-lazy-static($rust-type,$rust-ident,$type-initializer)
    }
}

our sub create-pub-const($rust-type,$rust-ident,$rust-initializer) {

    Rust::CrateItem.new(
        maybe-comment    => Nil,
        outer-attributes => [],
        item-variant => Rust::VisItem.new(
            maybe-visibility => Rust::VisibilityPublic.new,
            vis-item-variant => Rust::ConstantItem.new(
                identifier-or-underscore => $rust-ident,
                type                     => $rust-type,
                maybe-init-expression    => Rust::InitExpression.new(
                    expression => $rust-initializer
                ),
            )
        )
    )
}

multi sub translate-basic-declaration-to-rust(
    "T I;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T I;";

    my $rust-type  = to-rust-type($item.decl-specifier-seq);
    my $rust-ident = to-rust-ident($item.init-declarator-list[0], snake-case => True);

    my $default-initializer = create-default-initializer($rust-type);

    Rust::LetStatement.new(
        pattern-no-top-alt => Rust::IdentifierPattern.new(
            ref        => False,
            mutable    => True,
            identifier => $rust-ident,
        ),
        maybe-type       => Nil,
        maybe-expression => $default-initializer,
    )
}

multi sub translate-basic-declaration-to-rust(
    "T *I;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T *I;";

    my $rust-type  = Rust::RawPtrType.new(
        type-no-bounds => to-rust-type($item.decl-specifier-seq),
        mutable       => True,
    );

    my $rust-ident = to-rust-ident($item.init-declarator-list[0], snake-case => True);

    my $default-initializer = create-default-initializer($rust-type);

    Rust::LetStatement.new(
        pattern-no-top-alt => Rust::IdentifierPattern.new(
            ref        => False,
            mutable    => True,
            identifier => $rust-ident,
        ),
        maybe-type       => Nil,
        maybe-expression => $default-initializer,
    )
}


multi sub translate-basic-declaration-to-rust(
    "I(Es);",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask I(Es);";

    my $rust-ident = 
    to-rust-ident($item.init-declarator-list[0].declarator, snake-case => True).gist;

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
    ddt $item;
    exit;
}

multi sub translate-basic-declaration-to-rust(
    "T (I);",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T (I);";

    my $path-in-expr = to-rust-path-in-expression($item.decl-specifier-seq.value);

    my $rust-params = to-rust($item.init-declarator-list[0].pointer-declarator);

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => Rust::SuffixedExpression.new(
            base-expression => Rust::BaseExpression.new(
                expression-item => $path-in-expr
            ),
            suffixed-expression-suffix => [
                Rust::CallExpressionSuffix.new(
                    maybe-call-params => [
                        $rust-params
                    ]
                )
            ]
        )
    )
}

multi sub translate-basic-declaration-to-rust(
    "T (&I);",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T (&I);";

    my $path-in-expr = to-rust-path-in-expression($item.decl-specifier-seq.value);

    my $rust-param = Rust::BorrowExpression.new(
        borrow-expression-prefixes => [
            Rust::BorrowExpressionPrefix.new(
                borrow-count => 1,
                mutable      => False,
            )
        ],
        unary-expression => to-rust($item.init-declarator-list[0].pointer-declarator.no-pointer-declarator)
    );

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => Rust::SuffixedExpression.new(
            base-expression => Rust::BaseExpression.new(
                expression-item => $path-in-expr
            ),
            suffixed-expression-suffix => [
                Rust::CallExpressionSuffix.new(
                    maybe-call-params => [
                        $rust-param
                    ]
                )
            ]
        )
    )
}

multi sub translate-basic-declaration-to-rust(
    'T &I{E};',
    $item where Cpp::BasicDeclaration) 
{
    debug 'mask T &I{E};';

    my $idl = $item.init-declarator-list[0];

    #in cpp, here is where the reference is
    #in rust, we want it in a different place
    my $declarator 
    = $idl.declarator;

    my $initializer
    = $idl.initializer;

    my $decl-specifier-seq 
    = $item.decl-specifier-seq;

    my Bool $mutable = do if ($decl-specifier-seq.value ~~ Cpp::TrailingTypeSpecifier::CvQualifier).Bool {
        $decl-specifier-seq.value.cv-qualifier !~~ Cpp::CvQualifier::Const_ 
    } else {
        False
    };

    my $rust-ident = to-rust-ident(

        #we pull off the reference from c++ and
        #manually insert it below
        $declarator.no-pointer-declarator, 

        snake-case => True
    );

    my $rust-type  = to-rust-type($decl-specifier-seq);

    my $type-initializer
    = to-rust-params($initializer.brace-or-equal-initializer);

    Rust::LetStatement.new(
        pattern-no-top-alt => $rust-ident,
        maybe-type         => Rust::ReferenceType.new(
            mutable        => $mutable,
            type-no-bounds => $rust-type
        ),
        maybe-expression   => $type-initializer,
    )
}

multi sub translate-basic-declaration-to-rust(
    'I();',
    $item where Cpp::BasicDeclaration) 
{
    debug 'mask I();';

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => to-rust($item.init-declarator-list[0])
    )
}

multi sub translate-basic-declaration-to-rust(
    'T I{(I + I) % I};',
    $item where Cpp::BasicDeclaration) 
{
    debug 'mask T I{(I + I) % I};';
    translate-basic-declaration-to-rust('T I{E};', $item)
}

multi sub translate-basic-declaration-to-rust(
    'T I{I == I && I == I};',
    $item where Cpp::BasicDeclaration) 
{
    debug 'mask T I{I == I && I == I};';
    translate-basic-declaration-to-rust('T I{E};', $item)
}

multi sub translate-basic-declaration-to-rust(
    'T I{L};',
    $item where Cpp::BasicDeclaration) 
{
    debug 'mask T I{L};';
    translate-basic-declaration-to-rust('T I{E};', $item)
}

multi sub translate-basic-declaration-to-rust(
    'T I{* I};',
    $item where Cpp::BasicDeclaration) 
{
    debug 'mask T I{* I};';
    translate-basic-declaration-to-rust('T I{E};', $item)
}

multi sub translate-basic-declaration-to-rust(
    'T I{E};',
    $item where Cpp::BasicDeclaration) 
{
    debug 'mask T I{E};';

    my $idl = $item.init-declarator-list[0];

    my $declarator 
    = $idl.declarator;

    my $initializer
    = $idl.initializer;

    my $decl-specifier-seq 
    = $item.decl-specifier-seq;

    my $rust-ident = to-rust-ident($declarator, snake-case => True);
    my $rust-type  = to-rust-type($decl-specifier-seq);

    my $rust-params  
    = to-rust-params($initializer.brace-or-equal-initializer);

    my $type-initializer = create-type-initializer($rust-type,$rust-params);

    Rust::LetStatement.new(
        pattern-no-top-alt => $rust-ident,
        maybe-type         => $rust-type,
        maybe-expression   => $type-initializer,
    )
}

multi sub translate-basic-declaration-to-rust(
    "constexpr T I = E;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask constexpr T I = E;";

    my $idl = $item.init-declarator-list[0];

    my $declarator 
    = $idl.declarator;

    my $initializer
    = $idl.initializer;

    my $decl-specifier-seq 
    = $item.decl-specifier-seq;

    my $rust-ident = to-rust-ident($declarator, snake-case => True);
    my $rust-type  = to-rust-type($decl-specifier-seq.decl-specifiers.List);

    my $rust-expr  
    = to-rust($initializer.brace-or-equal-initializer);

    create-pub-const($rust-type,$rust-ident,$rust-expr)
}

multi sub translate-basic-declaration-to-rust(
    'constexpr T I{E};',
    $item where Cpp::BasicDeclaration) 
{
    debug 'mask constexpr T I{E};';

    my $idl = $item.init-declarator-list[0];

    my $declarator 
    = $idl.declarator;

    my $initializer
    = $idl.initializer;

    my $decl-specifier-seq 
    = $item.decl-specifier-seq;

    my $rust-ident = to-rust-ident($declarator, snake-case => True);
    my $rust-type  = to-rust-type($decl-specifier-seq.decl-specifiers.List);

    my $rust-expr  
    = to-rust($initializer.brace-or-equal-initializer);

    create-pub-const($rust-type,$rust-ident,$rust-expr)
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

    my $rust-ident = to-rust-ident($declarator, snake-case => True);
    my $rust-type  = to-rust-type($decl-specifier-seq);

    my $rust-expr  
    = to-rust($initializer.brace-or-equal-initializer);

    Rust::LetStatement.new(
        pattern-no-top-alt => $rust-ident,
        maybe-type         => $rust-type,
        maybe-expression   => $rust-expr,
    )
}

multi sub translate-basic-declaration-to-rust(
    "T I[E] = E;",
    $item where Cpp::BasicDeclaration) 
{
    my $arr-len     = to-rust($item.init-declarator-list[0].declarator.no-pointer-declarator-tail[0].constant-expression);

    my $rust-type = Rust::ArrayType.new(
        type       => to-rust-type($item.decl-specifier-seq),
        expression => $arr-len,
    );

    my $rust-ident = to-rust($item.init-declarator-list[0].declarator.no-pointer-declarator-base);
    my $rust-expr  = to-rust($item.init-declarator-list[0].initializer);

    Rust::LetStatement.new(
        pattern-no-top-alt => $rust-ident,
        maybe-type         => $rust-type,
        maybe-expression   => $rust-expr,
    )
}


multi sub translate-basic-declaration-to-rust(
    "I[N] = E;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask I[N] = E;";

    my $lhs = $item.init-declarator-list[0]
    .declarator;

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => Rust::AssignExpression.new(
            addeq-expressions => [

                #lhs
                to-rust-suffixed-expression($lhs),

                #rhs
                to-rust(
                    $item.init-declarator-list[0]
                    .initializer
                    .brace-or-equal-initializer
                    .initializer-clause
                ),
            ]
        )
    )
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

sub translate-standard-type-declarator($mask, $item where Cpp::BasicDeclaration) {

    my $valid-masks = [
        'T I(Es);',
        'T &I(Es);',
        'T I(E);',
        'T &I(E);',
    ].SetHash;

    die "bad mask $mask" if $mask !(elem) $valid-masks;

    my $idl = $item.init-declarator-list[0];

    my $declarator 
    = $idl.declarator;

    my $initializer
    = $idl.initializer;

    my $decl-specifier-seq 
    = $item.decl-specifier-seq;

    my Bool $do-type-deduction 
    = $decl-specifier-seq.value ~~ Cpp::SimpleTypeSpecifier::Auto_;

    my $is-const-type = is-const-type($decl-specifier-seq);
    my $is-ref-type   = is-ref($declarator);

    my $rust-type = to-rust-type($decl-specifier-seq);

    if $is-ref-type {
        $rust-type = Rust::ReferenceType.new(
            mutable        => not $is-const-type,
            type-no-bounds => $rust-type
        )
    }

    if $do-type-deduction {

        my $rust-ident = to-rust-ident($declarator, snake-case => True);
        my @rust-exprs = to-rust-params($initializer.expression-list).List;

        die if not @rust-exprs.elems eq 1;

        Rust::LetStatement.new(
            pattern-no-top-alt => $rust-ident,
            maybe-type         => Nil,
            maybe-expression   => @rust-exprs[0],
        )

    } else {

        do given $idl {
            when Cpp::InitDeclarator {
                my $rust-ident  = to-rust-ident($declarator, snake-case => True);
                my @rust-params = to-rust-params($initializer).List;

                if $is-ref-type {

                    #this is reference initialization
                    #see: https://en.cppreference.com/w/cpp/language/reference_initialization
                    die if not @rust-params.elems eq 1;

                    Rust::LetStatement.new(
                        pattern-no-top-alt => $rust-ident,
                        maybe-type         => $rust-type,
                        maybe-expression   => @rust-params[0],
                    )

                } else {

                    RustBasicCreationEvent.new(
                        :$rust-ident,
                        :$rust-type,
                        :@rust-params,
                    ).gist
                }

            }
            default {
                die "need implement for {$idl.WHAT.^name}";
            }
        }
    }
}

multi sub translate-basic-declaration-to-rust(
    "T I(Es);",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T I(Es);";

    my $mask = 'T I(Es);';

    translate-standard-type-declarator($mask, $item)
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
            my $rust-ident  = to-rust-ident($declarator0.no-pointer-declarator-base, snake-case => True);
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
    "I = I(Es);",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask I = I(Es);";
    die "check this dispatch";

    my $lhs = to-rust($item.init-declarator-list[0].declarator);
    my $rhs = to-rust($item.init-declarator-list[0].initializer.brace-or-equal-initializer.initializer-clause);

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => Rust::AssignExpression.new(
            addeq-expressions => [
                $lhs,
                $rhs,
            ]
        )
    )
}

multi sub translate-basic-declaration-to-rust(
    "I[I + E + N] = I & NI;",
    $item where Cpp::BasicDeclaration) 
{
    translate-basic-declaration-to-rust("I[E] = E;", $item)
}

multi sub translate-basic-declaration-to-rust(
    "I[I + E + N] = I & N;",
    $item where Cpp::BasicDeclaration) 
{
    translate-basic-declaration-to-rust("I[E] = E;", $item)
}

multi sub translate-basic-declaration-to-rust(
    "I[E] = E;",
    $item where Cpp::BasicDeclaration) 
{
    my $rust-ident = to-rust($item.init-declarator-list[0].declarator);
    my $rust-rhs   = to-rust($item.init-declarator-list[0].initializer.brace-or-equal-initializer.initializer-clause);

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => Rust::AssignExpression.new(
            addeq-expressions => [
                $rust-ident,
                $rust-rhs,
            ]
        )
    )
}

multi sub translate-basic-declaration-to-rust(
    "I = E;",
    $item where Cpp::BasicDeclaration) 
{
    my $rust-ident = to-rust-ident($item.init-declarator-list[0].declarator, snake-case => True);
    my $rust-rhs   = to-rust($item.init-declarator-list[0].initializer.brace-or-equal-initializer.initializer-clause);

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => Rust::AssignExpression.new(
            addeq-expressions => [
                $rust-ident,
                $rust-rhs,
            ]
        )
    )
}

sub emit-basic-let-statement($item where Cpp::BasicDeclaration) {

    my $rust-type  = to-rust-type($item.decl-specifier-seq);
    my $rust-ident = to-rust-ident($item.init-declarator-list[0].declarator, snake-case => True);
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
    )
}

multi sub translate-basic-declaration-to-rust(
    "I[I] = E;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask I[I] = E;";

    my $rust-lhs 
    = to-rust($item.init-declarator-list[0].declarator);

    my $rust-rhs   
    = to-rust(
        $item.init-declarator-list[0].initializer.brace-or-equal-initializer.initializer-clause
    );

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => Rust::AssignExpression.new(
            addeq-expressions => [
                $rust-lhs,
                $rust-rhs,
            ]
        )
    )
}

#--------------------------------
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

    my $rust-ident = to-rust-ident($declarator.no-pointer-declarator, snake-case => True);

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

    $rust-let-stmt
}

multi sub translate-basic-declaration-to-rust(
    'T *I{E};',
    $item where Cpp::BasicDeclaration) 
{
    debug 'mask T *I{E};';

    my Bool $do-type-deduction 
    = $item.decl-specifier-seq.value ~~ Cpp::SimpleTypeSpecifier::Auto_;

    my $idl = $item.init-declarator-list[0];

    my $declarator 
    = $idl.declarator;

    my $initializer
    = $idl.initializer;

    my $rust-ident = to-rust-ident($declarator.no-pointer-declarator, snake-case => True);

    my $rust-expr  
    = to-rust($initializer.brace-or-equal-initializer.initializer-list).join(", ");

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

    $rust-let-stmt
}

multi sub translate-basic-declaration-to-rust(
    "T *I = & E;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T *I = & E;";
    #ddt $item;

    die "check this dispatch";

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
