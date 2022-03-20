
# rule attribute-specifier-seq { <attribute-specifier>+ }
our class AttributeSpecifierSeq { 
    has IAttributeSpecifier @.attribute-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule attribute-specifier:sym<double-braced> { 
#   <.left-bracket> 
#   <.left-bracket> 
#   <attribute-list>? 
#   <.right-bracket> 
#   <.right-bracket> 
# }
our class AttributeSpecifier::DoubleBraced does IAttributeSpecifier {
    has AttributeList $.attribute-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attribute-specifier:sym<alignment> { 
#   <alignmentspecifier> 
# }
our class AttributeSpecifier::Alignment does IAttributeSpecifier {
    has IAlignmentSpecifier $.alignmentspecifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attribute-list { 
#   <attribute> 
#   [ <.comma> <attribute> ]* 
#   <ellipsis>? 
# }
our class AttributeList { 
    has Attribute @.attributes is required;
    has Bool      $.has-ellipsis is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attribute { 
#   [ <attribute-namespace> <doublecolon> ]? 
#   <identifier> 
#   <attribute-argument-clause>? 
# }
our class Attribute { 
    has AttributeNamespace      $.attribute-namespace;
    has Identifier              $.identifier is required;
    has AttributeArgumentClause $.attribute-argument-clause;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attribute-namespace { <identifier> }
our class AttributeNamespace { 
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attribute-argument-clause { 
#   <.left-paren> 
#   <balanced-token-seq>? 
#   <.right-paren> 
# }
our class AttributeArgumentClause { 
    has BalancedTokenSeq $.balanced-token-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role AttributeSpecifierSeq::Actions {

    # rule attribute-specifier-seq { <attribute-specifier>+ } 
    method attribute-specifier-seq($/) {
        make $<attribute-specifier>>>.made
    }

    # rule attribute-specifier:sym<double-braced> { <.left-bracket> <.left-bracket> <attribute-list>? <.right-bracket> <.right-bracket> }
    method attribute-specifier:sym<double-braced>($/) {
        make $<attribute-list>.made
    }

    # rule attribute-specifier:sym<alignment> { <alignmentspecifier> } 
    method attribute-specifier:sym<alignment>($/) {
        make $<alignmentspecifier>.made
    }

    # rule attribute-list { <attribute> [ <.comma> <attribute> ]* <ellipsis>? }
    method attribute-list($/) {

        my $has-ellipsis = so $/<ellipsis>:exists;
        my @attribs      = $<attribute>>>.made;

        if $has-ellipsis {

            make AttributeList.new(
                attributes   => @attribs,
                has-ellipsis => $has-ellipsis,
            )

        } else {
            make @attribs[0]
        }
    }

    # rule attribute { [ <attribute-namespace> <doublecolon> ]? <identifier> <attribute-argument-clause>? }
    method attribute($/) {
        make Attribute.new(
            attribute-namespace       => $<attribute-namespace>.made,
            identifier                => $<identifier>.made,
            attribute-argument-clause => $<attribute-argument-clause>.made,
        )
    }

    # rule attribute-namespace { <identifier> }
    method attribute-namespace($/) {
        make $<identifier>.made
    }

    # rule attribute-argument-clause { <.left-paren> <balanced-token-seq>? <.right-paren> }
    method attribute-argument-clause($/) {
        make $<balanced-token-seq>.made
    }
}

our role AttributeSpecifierSeq::Rules {

    rule attribute-list {
        <attribute>
        [ <comma> <attribute> ]*
        <ellipsis>?
    }

    rule attribute {
        [ <attribute-namespace> <doublecolon> ]?
        <identifier>
        <attribute-argument-clause>?
    }

    rule attribute-namespace {
        <identifier>
    }

    rule attribute-argument-clause {
        <left-paren> <balanced-token-seq>?  <right-paren>
    }

    rule attribute-specifier-seq {
        <attribute-specifier>+
    }

    #--------------------
    proto rule attribute-specifier { * }

    rule attribute-specifier:sym<double-braced> {
        <left-bracket>
        <left-bracket>
        <attribute-list>?
        <right-bracket>
        <right-bracket>
    }

    rule attribute-specifier:sym<alignment> {
        <alignmentspecifier>
    }
}
