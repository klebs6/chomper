use Chomper::Cpp::Gcpp;
use Chomper::Case;

our sub cpp-grammar-methods($marker = Nil) {

    my @grammar-methods = 
    [
        #|CPP14Keyword.^methods(:all),
        |CPP14Lexer.^methods(:all),
        |CPP14Parser.^methods(:all),
    ];

    if $marker {

        die if not $marker ~~ Str;

        my $marker-idx   
        = @grammar-methods.first(:k, {$_.name ~~ /$marker/});

        @grammar-methods[$marker-idx..*]

    } else {
        @grammar-methods
    }
}

our sub cpp-grammar-tokens(@grammar-methods) {

    @grammar-methods
    ==> map({
        $_.name
    })
    ==> sort()
    ==> unique()
    ==> my @tokens;

    @tokens
}

our sub get-inner-value-of-sym-rule($name) {

    my $sub  = $name.split(":sym")[1];

    if $sub {
        $sub ~~ s:g/'<' (.*) '>'/$0/;
    }

    $sub
}

our class RegexQuantifier {
    has Bool $.is-required is required;
    has Bool $.is-plural   is required;
}

our class RegexItem {
    has                 $.name is required;
    has Bool            $.hidden is required;
    has RegexQuantifier $.quantifier;
}

our class BasicToken {
    has RegexItem @.items is required;
    has           $.base  is required;
    has           $.sym;

    method gist {
        do for @.items {
            if not $_.hidden {
                if $_.quantifier {
                    my $sigil = $_.quantifier.is-plural   ?? "@" !! "\$";
                    my $req   = $_.quantifier.is-required ?? " is required" !! "";
                    my $name  = $_.name ~~ "sym" ?? $.sym !! $_.name;
                    my $type  = kebab-to-camel($name);
                    "has {$type} {$sigil}.{$name}{$req};"
                } else {
                    my $name  = $_.name ~~ "sym" ?? $.sym !! $_.name;
                    my $type  = kebab-to-camel($name);
                    "has {$type} \$.{$name};"
                }
            }
        }.join("\n")
    }
}

#use Grammar::Tracer;
our grammar BasicToken::Grammar {
    rule TOP {
        <.ws> 
        <keyword> 
        <token-name>
        '{' <token-body> '}'
    }

    token token-name {
        <base-name> 
        <sym-clause>? 
    }
    
    proto token keyword { * }
    token keyword:sym<token> { token }
    token keyword:sym<rule>  { rule  }
    token keyword:sym<regex> { regex }

    token token-ident {
        <hidden>? <body>
    }

    token hidden {
        '.'
    }

    token body {
        <[A..Z a..z \- _ 0..9 ]>+
    }

    token base-name {
        <token-ident>
    }

    token sym-clause {
        ':sym<' <token-ident> '>'
    }

    token basic-token-base {
        '<' <token-ident> '>'
    }

    proto token basic-token-quantifier { * }
    token basic-token-quantifier:sym<*> { <sym> }
    token basic-token-quantifier:sym<+> { <sym> }
    token basic-token-quantifier:sym<?> { <sym> }

    token basic-token-item {
        <basic-token-base> <basic-token-quantifier>?
    }

    rule token-body {
        <basic-token-item> [<.ws> <basic-token-item>]*
    }
}

our class BasicToken::Actions {

    method TOP($/) {
        make BasicToken.new(
            items => $<token-body><basic-token-item>>>.made,
            base  => ~$<token-name><base-name><token-ident><body>,
            sym   => ~$<token-name><sym-clause><token-ident><body> // Nil,
        )
    }

    method basic-token-item($/) {
        make RegexItem.new(
            name        => ~$<basic-token-base><token-ident><body>,
            hidden      => $<basic-token-base><token-ident><hidden> ?? True !! False,
            quantifier  => $<basic-token-quantifier>.made // RegexQuantifier.new(is-plural => False, is-required => True),
        )
    }

    method basic-token-quantifier:sym<*>($/) {
        make RegexQuantifier.new(
            is-required => True,
            is-plural   => True,
        )
    }

    method basic-token-quantifier:sym<+>($/) {
        make RegexQuantifier.new(
            is-required => True,
            is-plural   => True,
        )
    }

    method basic-token-quantifier:sym<?>($/) {
        make RegexQuantifier.new(
            is-required => False,
            is-plural   => False,
        )
    }
}

our sub get-regex-children(@grammar-methods, $tok) {

    #say "get-regex-children: {$tok.name}";

    my @tokens = @grammar-methods.grep: {$_.name eq $tok.name};

    die if not @tokens.elems eq 1;

    my $tok-str = @tokens[0].gist;

    my $parsed = BasicToken::Grammar.parse(
        $tok-str, 
        actions => BasicToken::Actions.new
    );

    #say $parsed;

    if $parsed {

        $parsed.made.gist.split("\n")

    } else {
        []
    }
}

our sub get-sym-rule-interfaces(@grammar-tokens) {

    my @interfaces = do for @grammar-tokens {

        my $x = $_.split(":sym");

        if $x.elems eq 2 {
            $x[0]
        }

    }.SetHash.sort>>.key.List;
}

our class InheritanceMap {
    has %.map            is required;
    has @.non-inheritors is required;
}

our sub build-token-inheritance-maps(@grammar-tokens --> InheritanceMap) {

    my %inheritance-map;
    my @non-inheritors;

    for @grammar-tokens {

        my $base = $_.split(":sym")[0];
        my $sub  = get-inner-value-of-sym-rule($_);

        if $sub {
            %inheritance-map{$base}.push: $sub;
        } else {
            @non-inheritors.push: $base;
        }
    }

    InheritanceMap.new(
        map            => %inheritance-map,
        non-inheritors => @non-inheritors
    )
}

our sub class-name($token-name) {
    my $base   = $token-name.split(":sym")[0];
    my $base-x = kebab-to-camel($base);
    my $sub    = get-inner-value-of-sym-rule($token-name);

    if $sub {
        my $sub-x  = kebab-to-camel($sub) // Nil;
        "$base-x\:\:$sub-x"
    } else {
        $base-x
    }
}

our sub generate-cpp-model(@grammar-methods) {

    my @grammar-tokens = cpp-grammar-tokens(@grammar-methods);
    my @interfaces     = get-sym-rule-interfaces(@grammar-tokens);

    my InheritanceMap $inheritance-map 
    = build-token-inheritance-maps(@grammar-tokens);

    my @class-defs = do for @grammar-methods {

        my $tok     = $_;
        my $tok-str = $tok.gist.split("\n").join(" ").subst(:g, /\h+/, " ");
        my $name    = $tok.name;

        my $base   = $name.split(":sym")[0];
        my $base-x = kebab-to-camel($base);

        my $sub    = get-inner-value-of-sym-rule($name);

        if $sub {

            my $sub-x  = kebab-to-camel($sub);

            my $klass = "$base-x\:\:$sub-x";
            my $role  = "I$base-x";

            my @children = get-regex-children(@grammar-methods, $tok);

            qq:to/END/
            # $tok-str
            our class $klass does $role \{
            {
                @children.elems 
                ?? @children.join("\n").indent(4) 
                !! "#TODO".indent(4)
            }
            \}
            END

        } else {

            if $inheritance-map.map{$base}:exists {

                my $role  = "I$base-x";

                qq:to/END/
                our role $role \{ \}
                END

            } else {

                my $klass = "$base-x";

                qq:to/END/
                # $tok-str
                our class $klass \{ 
                    #TODO
                \}
                END
            }
        }
    };

    @class-defs
}
