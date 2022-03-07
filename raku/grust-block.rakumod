use Data::Dump::Tree;

our class ExprBlock {
    has $.comment;
    has $.maybe-inner-attrs;
    has $.maybe-stmts;

    has $.text;

    method gist {

        my $inner-attrs = $.maybe-inner-attrs ?? $.maybe-inner-attrs.gist ~ "\n" !! "";
        my $stmts       = $.maybe-stmts>>.gist>>.indent(4).join("\n");
        my $comment     = $.comment ?? $.comment.gist ~ "\n" !! "";
        my $inner       = "$inner-attrs$stmts";

        if $inner.split(";").elems gt 1 or $inner.chars gt 20 {
            qq:to/END/.trim.chomp
            $comment\{
                $inner
            \}
            END

        } else {
            qq:to/END/.trim.chomp
            $comment\{ {$inner.trim.chomp} \}
            END
        }
    }
}

our role InnerAttrsAndBlock::Rules {

    rule inner-attrs-and-block {
        '{' 
        <maybe-inner-attrs> 
        <maybe-stmts> 
        <comment>? 
        '}'
    }
}

our role InnerAttrsAndBlock::Actions {

    method inner-attrs-and-block($/) {
        make ExprBlock.new(
            maybe-inner-attrs =>  $<maybe-inner-attrs>.made,
            maybe-stmts       =>  $<maybe-stmts>.made,
            comment           =>  $<comment>.made,
            text              => ~$/,
        )
    }
}

#---------------------------------

our role Block::Rules {

    rule block {
        '{' <maybe-stmts> <comment>? '}'
    }
}

our role Block::Actions {

    method block($/) {
        make ExprBlock.new(
            maybe-stmts =>  $<maybe-stmts>.made,
            comment     =>  $<comment>.made,
            text        => ~$/,
        )
    }
}
