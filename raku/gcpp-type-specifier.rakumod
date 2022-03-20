# rule trailing-type-specifier:sym<cv-qualifier> { 
#   <cv-qualifier> 
#   <simple-type-specifier> 
# }
our class TrailingTypeSpecifier::CvQualifier does ITrailingTypeSpecifier {
    has ICvQualifier         $.cv-qualifier          is required;
    has ISimpleTypeSpecifier $.simple-type-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule type-specifier-seq { 
#   <type-specifier>+ 
#   <attribute-specifier-seq>? 
# }
our class TypeSpecifierSeq does ITypeSpecifierSeq { 
    has ITypeNameSpecifier     @.type-specifiers is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule trailing-type-specifier-seq { 
#   <trailing-type-specifier>+ 
#   <attribute-specifier-seq>? 
# }
our class TrailingTypeSpecifierSeq { 
    has ITrailingTypeSpecifier @.trailing-type-specifiers is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role TypeSpecifier::Actions {

    # rule type-specifier:sym<trailing-type-specifier> { <trailing-type-specifier> }
    method type-specifier:sym<trailing-type-specifier>($/) {
        make $<trailing-type-specifier>.made
    }

    # rule type-specifier:sym<class-specifier> { <class-specifier> }
    method type-specifier:sym<class-specifier>($/) {
        make $<class-specifier>.made
    }

    # rule type-specifier:sym<enum-specifier> { <enum-specifier> } 
    method type-specifier:sym<enum-specifier>($/) {
        make $<enum-specifier>.made
    }

    # rule trailing-type-specifier:sym<cv-qualifier> { <cv-qualifier> <simple-type-specifier> }
    method trailing-type-specifier:sym<cv-qualifier>($/) {
        make TrailingTypeSpecifier::CvQualifier.new(
            cv-qualifier          => $<cv-qualifier>.made,
            simple-type-specifier => $<simple-type-specifier>.made,
        )
    }

    # rule trailing-type-specifier:sym<simple> { <simple-type-specifier> }
    method trailing-type-specifier:sym<simple>($/) {
        make $<simple-type-specifier>.made
    }

    # rule trailing-type-specifier:sym<elaborated> { <elaborated-type-specifier> }
    method trailing-type-specifier:sym<elaborated>($/) {
        make $<elaborated-type-specifier>.made
    }

    # rule trailing-type-specifier:sym<typename> { <type-name-specifier> } 
    method trailing-type-specifier:sym<typename>($/) {
        make $<type-name-specifier>.made
    }

    # rule type-specifier-seq { <type-specifier>+ <attribute-specifier-seq>? }
    method type-specifier-seq($/) {

        my $tail  = $<attribute-specifier-seq>.made;
        my @items = $<type-specifier>>>.made;

        if $tail or @items.elems gt 1 {

            make TypeSpecifierSeq.new(
                type-specifiers         => @items,
                attribute-specifier-seq => $tail,
            )

        } else {

            make @items[0]
        }
    }

    # rule trailing-type-specifier-seq { <trailing-type-specifier>+ <attribute-specifier-seq>? }
    method trailing-type-specifier-seq($/) {
        my $tail  = $<attribute-specifier-seq>.made;
        my @items = $<trailing-type-specifier>>>.made;

        if $tail or @items.elems gt 1 {
            make TrailingTypeSpecifierSeq.new(
                trailing-type-specifiers => @items,
                attribute-specifier-seq  => $tail,
            )
        } else {
            make @items[0]
        }
    }

    # rule simple-int-type-specifier { <simple-type-signedness-modifier>? <simple-type-length-modifier>* <int_> }
    method simple-int-type-specifier($/) {
        make SimpleIntTypeSpecifier.new(
            simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
            simple-type-length-modifiers    => $<simple-type-length-modifier>>>.made,
        )
    }

    # rule simple-char-type-specifier { <simple-type-signedness-modifier>? <char_> }
    method simple-char-type-specifier($/) {
        make SimpleCharTypeSpecifier.new(
            simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
        )
    }

    # rule simple-char16-type-specifier { <simple-type-signedness-modifier>? <char16> }
    method simple-char16-type-specifier($/) {
        make SimpleChar16TypeSpecifier.new(
            simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
        )
    }

    # rule simple-char32-type-specifier { <simple-type-signedness-modifier>? <char32> }
    method simple-char32-type-specifier($/) {
        make SimpleChar32TypeSpecifier.new(
            simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
        )
    }

    # rule simple-wchar-type-specifier { <simple-type-signedness-modifier>? <wchar> }
    method simple-wchar-type-specifier($/) {
        make SimpleWcharTypeSpecifier.new(
            simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
        )
    }

    # rule simple-double-type-specifier { <simple-type-length-modifier>? <double> } 
    method simple-double-type-specifier($/) {
        make SimpleDoubleTypeSpecifier.new(
            simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
        )
    }

    # regex simple-type-specifier:sym<int> { <simple-int-type-specifier> }
    method simple-type-specifier:sym<int>($/) {
        make $<simple-int-type-specifier>.made
    }

    # regex simple-type-specifier:sym<full> { <full-type-name> }
    method simple-type-specifier:sym<full>($/) {
        make $<full-type-name>.made
    }

    # regex simple-type-specifier:sym<scoped> { <scoped-template-id> }
    method simple-type-specifier:sym<scoped>($/) {
        make $<scoped-template-id>.made
    }

    # regex simple-type-specifier:sym<signedness-mod> { <simple-type-signedness-modifier> }
    method simple-type-specifier:sym<signedness-mod>($/) {
        make $<simple-type-signedness-modifier>.made
    }

    # regex simple-type-specifier:sym<signedness-mod-length> { 
    #   <simple-type-signedness-modifier>? 
    #   <simple-type-length-modifier>+ 
    # }
    method simple-type-specifier:sym<signedness-mod-length>($/) {
        make SimpleTypeSpecifier::SignednessModLength.new(
            simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
            simple-type-length-modifier     => $<simple-type-length-modifier>>>.made,
        )
    }

    # regex simple-type-specifier:sym<char> { <simple-char-type-specifier> }
    method simple-type-specifier:sym<char>($/) {
        make $<simple-char-type-specifier>.made
    }

    # regex simple-type-specifier:sym<char16> { <simple-char16-type-specifier> }
    method simple-type-specifier:sym<char16>($/) {
        make $<simple-char16-type-specifier>.made
    }

    # regex simple-type-specifier:sym<char32> { <simple-char32-type-specifier> }
    method simple-type-specifier:sym<char32>($/) {
        make $<simple-char32-type-specifier>.made
    }

    # regex simple-type-specifier:sym<wchar> { <simple-wchar-type-specifier> }
    method simple-type-specifier:sym<wchar>($/) {
        make $<simple-wchar-type-specifier>.made
    }

    # regex simple-type-specifier:sym<bool> { <bool_> }
    method simple-type-specifier:sym<bool>($/) {
        make SimpleTypeSpecifier::Bool.new
    }

    # regex simple-type-specifier:sym<float> { <float> }
    method simple-type-specifier:sym<float>($/) {
        make SimpleTypeSpecifier::Float.new
    }

    # regex simple-type-specifier:sym<double> { <simple-double-type-specifier> }
    method simple-type-specifier:sym<double>($/) {
        make $<simple-double-type-specifier>.made
    }

    # regex simple-type-specifier:sym<void> { <void_> }
    method simple-type-specifier:sym<void>($/) {
        make SimpleTypeSpecifier::Void.new
    }

    # regex simple-type-specifier:sym<auto> { <auto> }
    method simple-type-specifier:sym<auto>($/) {
        make SimpleTypeSpecifier::Auto.new
    }

    # regex simple-type-specifier:sym<decltype> { <decltype-specifier> } 
    method simple-type-specifier:sym<decltype>($/) {
        make $<decltype-specifier>.made
    }
}
