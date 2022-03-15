our class MatchExpression {
    has $.scrutinee;
    has @.inner-attributes;
    has $.maybe-match-arms;

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

our class Scrutinee {
    has $.expression-nostruct;

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

our class MatchArms {
    has @.items;
    has $.maybe-comment;

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

our class MatchArmsInnerItemWithBlock {
    has $.maybe-comment;
    has $.match-arm;
    has $.expression-with-block;

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

our class MatchArmsInnerItemWithoutBlock {
    has $.maybe-comment;
    has $.match-arm;
    has $.expresison-noblock;

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

our class MatchArmsOuterItem {
    has $.maybe-comment;
    has $.match-arm;
    has $.expression;

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

our class MatchArm {
    has @.outer-attributes;
    has $.pattern;
    has $.maybe-match-arm-guard;

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

our class MatchArmGuard {
    has $.expression;

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

our role MatchExpression::Rules {

    rule match-expression {
        <kw-match> 
        <scrutinee> 
        <tok-lbrace>
        <inner-attribute>*
        <match-arms>?
        <tok-rbrace>
    }

    rule scrutinee {
        <expression-nostruct>
    }

    rule scrutinee-except-lazy-boolean-operator-expression {
        <scrutinee> <?{$0 !~~ <binary-oror-expression>}>
    }

    #------------------
    rule match-arms {
        <match-arms-inner-item>*
        <match-arms-outer-item>
        <comment>?
    }

    proto rule match-arms-inner-item { * }

    rule match-arms-inner-item:sym<with-block> {  
        <comment>?
        <match-arm>
        <tok-fat-rarrow>
        <expression-with-block>
        <tok-comma>?
    }

    rule match-arms-inner-item:sym<without-block> {  
        <comment>?
        <match-arm> 
        <tok-fat-rarrow> 
        <expression-noblock> 
        <tok-comma>
    }

    proto rule expression-variant { * }
    rule expression-variant:sym<with>    { <expression-with-block> }
    rule expression-variant:sym<without> { <expression-noblock> }

    rule match-arms-outer-item {
        <comment>?
        <match-arm> 
        <tok-fat-rarrow> 
        <expression-variant>
        <tok-comma>?
    }

    rule match-arm {
        <outer-attribute>*
        <pattern>
        <match-arm-guard>?
    }

    rule match-arm-guard {
        <kw-if> <expression>
    }

}

our role MatchExpression::Actions {

    method match-expression($/) {
        make MatchExpression.new(
            scrutinee        => $<scrutinee>.made,
            inner-attributes => $<inner-attribute>>>.made,
            maybe-match-arms => $<match-arms>.made,
            text       => $/.Str,
        )
    }

    method scrutinee($/) {
        make Scrutinee.new(
            expression-nostruct => $<expression-nostruct>.made,
            text       => $/.Str,
        )
    }

    method scrutinee-except-lazy-boolean-operator-expression($/) {
        make $<scrutinee>.made
    }

    #------------------
    method match-arms($/) {
        make MatchArms.new(
            items => [
                |$<match-arms-inner-item>>>.made, 
                $<match-arms-outer-item>.made
            ],
            maybe-comment => $<comment>.made,
            text       => $/.Str,
        )
    }

    method match-arms-inner-item:sym<with-block>($/) {  
        make MatchArmsInnerItemWithBlock.new(
            maybe-comment         => $<comment>.made,
            match-arm             => $<match-arm>.made,
            expression-with-block => $<expression-with-block>.made,
            text       => $/.Str,
        )
    }

    method match-arms-inner-item:sym<without-block>($/) {  
        make MatchArmsInnerItemWithoutBlock.new(
            maybe-comment      => $<comment>.made,
            match-arm          => $<match-arm>.made,
            expresison-noblock => $<expression-noblock>.made,
            text       => $/.Str,
        )
    }

    method expression-variant:sym<with>($/)    { make $<expression-with-block>.made }
    method expression-variant:sym<without>($/) { make $<expression-noblock>.made }

    method match-arms-outer-item($/) {
        make MatchArmsOuterItem.new(
            maybe-comment => $<comment>.made,
            match-arm     => $<match-arm>.made,
            expression    => $<expression-variant>.made,
            text       => $/.Str,
        )
    }

    method match-arm($/) {
        make MatchArm.new(
            outer-attributes      => $<outer-attribute>>>.made,
            pattern               => $<pattern>.made,
            maybe-match-arm-guard => $<match-arm-guard>.made,
            text       => $/.Str,
        )
    }

    method match-arm-guard($/) {
        make MatchArmGuard.new(
            expression => $<expression>.made,
            text       => $/.Str,
        )
    }
}
