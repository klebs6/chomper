our role Module::Rules {

    proto rule module { * }

    rule module:sym<semi> {
        <kw-unsafe>? 
        <kw-mod> 
        <identifier> 
        <tok-semi>
    }

    rule module:sym<block> {
        <kw-unsafe>?
        <kw-mod>
        <identifier>
        <tok-lbrace>
        <inner-attribute>*
        <item>*
        <tok-rbrace>
    }
}

our role Module::Actions {}
