use Data::Dump::Tree;

our class IfExpression {
    has $.expression-nostruct;
    has $.block-expression;
    has $.maybe-else-clause;

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

our class IfLetExpression {
    has $.pattern;
    has $.scrutinee;
    has $.block-expression;
    has $.maybe-else-clause;

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

our class ElseClause {
    has $.else-clause-variant;

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

our role IfExpressions::Rules {

    rule if-expression {
        <kw-if>
        <expression-nostruct>
        <block-expression>
        <else-clause>?
    }

    rule if-let-expression {
        <kw-if>
        <kw-let>
        <pattern>
        <tok-eq>
        <scrutinee-except-lazy-boolean-operator-expression>
        <block-expression>
        <else-clause>?
    }

    rule else-clause {
        <kw-else>
        <else-clause-variant>
    }

    proto rule else-clause-variant { * }

    rule else-clause-variant:sym<block> {  
        <block-expression>
    }

    rule else-clause-variant:sym<if> {  
        <if-expression>
    }

    rule else-clause-variant:sym<if-let> {  
        <if-let-expression>
    }
}

our role IfExpressions::Actions {

    method if-expression($/) {
        make IfExpression.new(
            expression-nostruct => $<expression-nostruct>.made,
            block-expression    => $<block-expression>.made,
            maybe-else-clause   => $<else-clause>.made,
            text                => $/.Str,
        )
    }

    method if-let-expression($/) {
        make IfLetExpression.new(
            pattern           => $<pattern>.made,
            scrutinee         => $<scrutinee-except-lazy-boolean-operator-expression>.made,
            block-expression  => $<block-expression>.made,
            maybe-else-clause => $<else-clause>.made,
            text              => $/.Str,
        )
    }

    method else-clause($/) {
        make ElseClause.new(
            else-clause-variant => $<else-clause-variant>.made,
            text                => $/.Str,
        )
    }

    method else-clause-variant:sym<block>($/) {  
        make $<block-expression>.made
    }

    method else-clause-variant:sym<if>($/) {  
        make $<if-expression>.made
    }

    method else-clause-variant:sym<if-let>($/) {  
        make $<if-let-expression>.made
    }
}
