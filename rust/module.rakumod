our role Module::Rules {

    proto rule module { * }

    rule module:sym<semi> {
        <tok-unsafe>? 
        <kw-mod> 
        <identifier> 
        <tok-semi>
    }

    rule module:sym<block> {
        <tok-unsafe>?
        <kw-mod>
        <identifier>
        <tok-lbrace>
        <inner-attribute>*
        <item>*
        <tok-rbrace>
    }
}
