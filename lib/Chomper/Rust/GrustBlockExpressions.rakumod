use Data::Dump::Tree;

our class BlockExpression {
    has @.inner-attributes;
    has $.statements;

    has $.text;

    method gist {
        if @.inner-attributes.elems {
            qq:to/END/.chomp.trim
            \{
            {@.inner-attributes>>.gist.join("\n").indent(4)}
            {$.statements.gist.indent(4)}
            \}
            END
        } else {
            qq:to/END/.chomp.trim
            \{
            {$.statements.gist.indent(4)}
            \}
            END
        }
    }
}

our class AsyncBlockExpression {

    has Bool $.move;
    has $.block-expression;

    has $.text;

    method gist {

        my $builder = "async ";

        if $.move {
            $builder ~= "move ";
        }

        $builder ~= $.block-expression.gist;

        $builder
    }
}

our class UnsafeBlockExpression {
    has $.block-expression;

    has $.text;

    method gist {
        my $builder = "unsafe ";

        $builder ~= $.block-expression.gist;

        $builder
    }
}

our role BlockExpression::Rules {

    rule block-expression {
        <tok-lbrace>
        <inner-attribute>*
        <statements>?
        <tok-rbrace>
    }

    rule async-block-expression {
        <kw-async>
        <kw-move>?
        <block-expression>
    }

    rule unsafe-block-expression {
        <kw-unsafe>
        <block-expression>
    }
}

our role BlockExpression::Actions {

    method block-expression($/) {
        make BlockExpression.new(
            inner-attributes => $<inner-attribute>>>.made,
            statements       => $<statements>.made,
            text             => $/.Str,
        )
    }

    method async-block-expression($/) {
        make AsyncBlockExpression.new(
            move             => so $/<kw-move>:exists,
            block-expression => $<block-expression>.made,
            text             => $/.Str,
        )
    }

    method unsafe-block-expression($/) {
        make UnsafeBlockExpression.new(
            block-expression => $<block-expression>.made,
            text             => $/.Str,
        )
    }
}
