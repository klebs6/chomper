our class ExprFnBlock {
    has $.ret_ty;
    has $.expr;
    has $.inferrable_params;
    has $.lambda_expr_nostruct_no_first_bar;
    has $.lambda_expr_no_first_bar;
    has $.expr_nostruct;
}

our class LambdaExpr::Rules {

    #---------------------
    proto rule lambda-expr { * }

    rule lambda-expr:sym<a> {
        {self.set-prec(LAMBDA)} <OROR> <ret-ty> <expr>
    }

    rule lambda-expr:sym<b> {
        {self.set-prec(LAMBDA)} '|' '|' <ret-ty> <expr>
    }

    rule lambda-expr:sym<c> {
        {self.set-prec(LAMBDA)} '|' <inferrable-params> '|' <ret-ty> <expr>
    }

    rule lambda-expr:sym<d> {
        {self.set-prec(LAMBDA)} '|' <inferrable-params> <OROR> <lambda-expr_no_first_bar>
    }

    #---------------------
    proto rule lambda-expr_no_first_bar { * }

    rule lambda-expr_no_first_bar:sym<a> {
        {self.set-prec(LAMBDA)} '|' <ret-ty> <expr>
    }

    rule lambda-expr_no_first_bar:sym<b> {
        {self.set-prec(LAMBDA)} <inferrable-params> '|' <ret-ty> <expr>
    }

    rule lambda-expr_no_first_bar:sym<c> {
        {self.set-prec(LAMBDA)} <inferrable-params> <OROR> <lambda-expr_no_first_bar>
    }

    #---------------------
    proto rule lambda-expr_nostruct { * }

    rule lambda-expr_nostruct:sym<a> {
        {self.set-prec(LAMBDA)} <OROR> <expr-nostruct>
    }

    rule lambda-expr_nostruct:sym<b> {
        {self.set-prec(LAMBDA)} '|' '|' <ret-ty> <expr-nostruct>
    }

    rule lambda-expr_nostruct:sym<c> {
        {self.set-prec(LAMBDA)} '|' <inferrable-params> '|' <expr-nostruct>
    }

    rule lambda-expr_nostruct:sym<d> {
        {self.set-prec(LAMBDA)} '|' <inferrable-params> <OROR> <lambda-expr_nostruct_no_first_bar>
    }

    #---------------------
    proto rule lambda-expr_nostruct_no_first_bar { * }

    rule lambda-expr_nostruct_no_first_bar:sym<a> {
        {self.set-prec(LAMBDA)} '|' <ret-ty> <expr-nostruct>
    }

    rule lambda-expr_nostruct_no_first_bar:sym<b> {
        {self.set-prec(LAMBDA)} <inferrable-params> '|' <ret-ty> <expr-nostruct>
    }

    rule lambda-expr_nostruct_no_first_bar:sym<c> {
        {self.set-prec(LAMBDA)} <inferrable-params> <OROR> <lambda-expr_nostruct_no_first_bar>
    }
}

our class LambdaExpr::Actions {

    method lambda-expr:sym<a>($/) {
        make ExprFnBlock.new(
            ret-ty =>  $<ret-ty>.made,
            expr   =>  $<expr>.made,
        )
    }

    method lambda-expr:sym<b>($/) {
        make ExprFnBlock.new(
            ret-ty =>  $<ret-ty>.made,
            expr   =>  $<expr>.made,
        )
    }

    method lambda-expr:sym<c>($/) {
        make ExprFnBlock.new(
            inferrable-params =>  $<inferrable-params>.made,
            ret-ty            =>  $<ret-ty>.made,
            expr              =>  $<expr>.made,
        )
    }

    method lambda-expr:sym<d>($/) {
        make ExprFnBlock.new(
            inferrable-params        =>  $<inferrable-params>.made,
            lambda-expr_no_first_bar =>  $<lambda-expr_no_first_bar>.made,
        )
    }

    method lambda-expr_no_first_bar:sym<a>($/) {
        make ExprFnBlock.new(
            ret-ty =>  $<ret-ty>.made,
            expr   =>  $<expr>.made,
        )
    }

    method lambda-expr_no_first_bar:sym<b>($/) {
        make ExprFnBlock.new(
            inferrable-params =>  $<inferrable-params>.made,
            ret-ty            =>  $<ret-ty>.made,
            expr              =>  $<expr>.made,
        )
    }

    method lambda-expr_no_first_bar:sym<c>($/) {
        make ExprFnBlock.new(
            inferrable-params        =>  $<inferrable-params>.made,
            lambda-expr_no_first_bar =>  $<lambda-expr_no_first_bar>.made,
        )
    }

    method lambda-expr_nostruct:sym<a>($/) {
        make ExprFnBlock.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr_nostruct:sym<b>($/) {
        make ExprFnBlock.new(
            ret-ty        =>  $<ret-ty>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr_nostruct:sym<c>($/) {
        make ExprFnBlock.new(
            inferrable-params =>  $<inferrable-params>.made,
            expr-nostruct     =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr_nostruct:sym<d>($/) {
        make ExprFnBlock.new(
            inferrable-params                 =>  $<inferrable-params>.made,
            lambda-expr_nostruct_no_first_bar =>  $<lambda-expr_nostruct_no_first_bar>.made,
        )
    }

    method lambda-expr_nostruct_no_first_bar:sym<a>($/) {
        make ExprFnBlock.new(
            ret-ty        =>  $<ret-ty>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr_nostruct_no_first_bar:sym<b>($/) {
        make ExprFnBlock.new(
            inferrable-params =>  $<inferrable-params>.made,
            ret-ty            =>  $<ret-ty>.made,
            expr-nostruct     =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr_nostruct_no_first_bar:sym<c>($/) {
        make ExprFnBlock.new(
            inferrable-params                 =>  $<inferrable-params>.made,
            lambda-expr_nostruct_no_first_bar =>  $<lambda-expr_nostruct_no_first_bar>.made,
        )
    }
}
