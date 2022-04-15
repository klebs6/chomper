our role BracedArrayLiteralRule {

    rule braced-array-literal {
        <braced-array-literal-tree>
    }

    rule braced-array-literal-tree {
        | <braced-array-literal-leaf>
        | <braced-array-literal-leaf-list>
        | <braced-array-literal-leaf-list-list>
    }

    rule braced-array-literal-leaf {
        '{' [ <default-value>+ %% "," ] '}'
    }

    rule braced-array-literal-leaf-list {
        '{' [ <braced-array-literal-leaf>+ %% "," ] '}'
    }

    rule braced-array-literal-leaf-list-list {
        '{' [ <braced-array-literal-leaf-list>+ %% "," ] '}'
    }
}
