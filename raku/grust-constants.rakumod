our role ConstantItem::Rules {

    rule init-expression {
        <tok-eq>
        <expression>
    }

    proto rule identifier-or-underscore { * }

    rule identifier-or-underscore:sym<identifier> {
        <identifier>
    }

    rule identifier-or-underscore:sym<underscore> {
        <tok-underscore>
    }

    rule constant-item {
        <kw-const> 
        <identifier-or-underscore> 
        <tok-colon> 
        <type> 
        <init-expression>?
        <tok-semi>
    }
}

our role ConstantItem::Actions {

}

our role StaticItem::Rules {
    rule static-item {
        <kw-static>
        <kw-mut>?
        <identifier>
        <tok-colon>
        <type>
        <init-expression>?
        <tok-semi>
    }
}

our role StaticItem::Actions {

}
