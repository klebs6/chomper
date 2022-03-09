use Data::Dump::Tree;
use nqp;

our class Stmt {
    has $.value;
    has $.comment;
    has Bool $.semi = $!value.semi;

    has $.text;

    submethod TWEAK {
        self.gist;
    }

    method gist {

        qq:to/END/.chomp;
        {$.comment ?? $.comment.gist ~ "\n" !! ""}{$.value.gist}{$.semi ?? ";" !! ""}
        END
    }
}

our class StmtLet {
    has $.maybe-outer-attrs;
    has $.let;
    has Bool $.semi = True;

    has $.text;

    method gist {
        if $.maybe-outer-attrs {
            qq:to/END/.trim.chomp
            {$.maybe-outer-attrs.gist}
            {$.let.gist}
            END
        } else {
            qq:to/END/.trim.chomp
            {$.let.gist}
            END
        }
    }
}

our class StmtItem {
    has      $.outer-attrs;
    has Bool $.public;
    has      $.stmt-item;
    has Bool $.semi = False;

    has $.text;

    method gist {
        qq:to/END/.chomp.trim
        {$.outer-attrs ?? $.outer-attrs.gist ~ "\n" !! ""}{$.public ?? "pub " !! ""}{$.stmt-item.gist}{$.semi ?? ";" !! ""}
        END
    }
}

our class StmtBlock {
    has $.maybe-outer-attrs;
    has $.block;
    has Bool $.semi = False;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class StmtBasic {
    has $.outer-attrs;
    has $.nonblock-expr;
    has Bool $.semi = True;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        if $.outer-attrs {
            qq:to/END/.chomp.trim
            {$.outer-attrs.gist}
            {$.nonblock-expr.gist}
            END

        } else {
            qq:to/END/.chomp.trim
            {$.nonblock-expr.gist}
            END
        }
    }
}

our role Stmts::Rules {

    rule maybe-stmts { 
        <stmts>? 
        <nonblock-expr>? 
    }

    rule stmts { <stmt>+ }

    proto rule stmt  { * }
    rule stmt:sym<a> { <comment>? <stmt-body> }
    rule stmt:sym<b> { <block-comment> }

    proto rule stmt-body  { * }
    rule stmt-body:sym<a> { <maybe-outer-attrs> <let> }
    rule stmt-body:sym<e> { <outer-attrs>? <kw-pub>? <stmt-item> }
    rule stmt-body:sym<f> { <full-block-expr> }
    rule stmt-body:sym<g> { <maybe-outer-attrs> <block> }
    rule stmt-body:sym<i> { <outer-attrs>? <nonblock-expr> ';' }
    rule stmt-body:sym<j> { ';' }
}


our role Stmts::Actions {

    method maybe-stmts($/) {
        my @stmts = $<stmts>.made.List;
        my $last  = $<nonblock-expr>.made;

        if @stmts[0] {

            if $last {
                @stmts.push: $last
            }

            make @stmts

        } else {

            if $last {
                make $last
            }
        }
    }

    method stmts($/) {
        make $<stmt>>>.made
    }

    method stmt:sym<a>($/) { 
        make Stmt.new(
            comment => $<comment>.made,
            value   => $<stmt-body>.made,
            text    => ~$/,
        )
    }

    method stmt:sym<b>($/) { 
        make $<block-comment>.made
    }

    method stmt-body:sym<a>($/) { 
        make StmtLet.new(
            let               => $<let>.made,
            maybe-outer-attrs => $<maybe-outer-attrs>.made,
            text              => ~$/,
        )
    }

    method stmt-body:sym<e>($/) { 
        make StmtItem.new(
            outer-attrs => $<outer-attrs>.made,
            public      => so $/<kw-pub>:exists,
            stmt-item   => $<stmt-item>.made,
            text        => ~$/,
        )
    }

    method stmt-body:sym<f>($/) { 
        make $<full-block-expr>.made 
    }

    method stmt-body:sym<g>($/) { 
        make StmtBlock.new(
            maybe-outer-attrs => $<maybe-outer-attrs>.made,
            block             => $<block>.made,
            text              => ~$/,
        )
    }

    method stmt-body:sym<i>($/) { 
        make StmtBasic.new(
            outer-attrs   => $<outer-attrs>.made,
            nonblock-expr => $<nonblock-expr>.made,
            text          => ~$/,
        )
    }
}

#------------------------------
# items that can appear in "stmts"
our role StmtItem::Rules {

    proto rule stmt-item { * }

    rule stmt-item:sym<static> { <item-static> }
    rule stmt-item:sym<const>  { <item-const> }
    rule stmt-item:sym<type>   { <item-type> }
    rule stmt-item:sym<block>  { <block-item> }
    rule stmt-item:sym<view>   { <view-item> }
}

our role StmtItem::Actions {

    method stmt-item:sym<static>($/) { make $<item-static>.made }
    method stmt-item:sym<const>($/)  { make $<item-const>.made }
    method stmt-item:sym<type>($/)   { make $<item-type>.made }
    method stmt-item:sym<block>($/)  { make $<block-item>.made }
    method stmt-item:sym<view>($/)   { make $<view-item>.made }
}
