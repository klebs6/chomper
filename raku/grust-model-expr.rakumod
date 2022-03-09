use Data::Dump::Tree;

our class ExprAddrOf {
    has $.maybe-mut;
    has $.expr;
    has $.count = 1;

    has $.text;

    method gist {

        die if not $.count eq 1 or $.count eq 2;

        my $sigil = $.count eq 1 ?? "&" !! "&&";

        my $maybe-mut = $.maybe-mut.gist ?? $.maybe-mut.gist ~ " " !! "";

        "{$sigil}{$maybe-mut}{$.expr.gist}"
    }
}

#-------------------------------------

our class NonBlockExpr {
    has $.comment;
    has $.base;
    has @.tail;

    has $.text;

    submethod TWEAK {
        self.gist;
    }

    method gist {

        my $body = [
            $.base.gist, 
            |@.tail>>.gist
        ].join("");

        if $.comment {
            qq:to/END/.chomp
            {$.comment.gist}
            $body
            END
        } else {
            $body
        }
    }
}

our class ExprField {
    has $.path-generic-args-with-colons;

    has $.text;

    submethod TWEAK {
        self.gist;
    }

    method gist {
        my $path = $.path-generic-args-with-colons.gist;
        ".$path"
    }
}

our class ExprIndex {

    has $.maybe-expr;
    has $.path-generic-args-with-colons;

    has $.text;

    submethod TWEAK {
        self.gist;
    }

    method gist {
        my $body = $.maybe-expr.gist;

        if $.path-generic-args-with-colons {
            my $pfx  = $.path-generic-args-with-colons.gist;

            "{$pfx}[{$body}]"

        } else {
            "[{$body}]"
        }

    }
}

our class ExprCall {
    has $.path-generic-args-with-colons;
    has $.maybe-exprs;

    has $.text;

    method gist {

        my $body = $.maybe-exprs ?? $.maybe-exprs>>.gist.join(", ") !! "";

        if $.path-generic-args-with-colons {
            my $pfx  = $.path-generic-args-with-colons.gist;

            "{$pfx}({$body})"

        } else {
            "({$body})"
        }
    }
}

our class ExprNoStruct {
    has $.base;
    has @.tail;

    has $.text;

    method gist {
        [$.base.gist, |@.tail>>.gist].join("")
    }
}

our class ExprLit {
    has $.lit;

    has $.text;

    method gist {
        "{$.lit.gist}"
    }
}

our class ExprPathSelf {

    has $.text;

    submethod TWEAK {
        self.gist;
    }

    method gist {
        "self"
    }
}

our class ExprPath {
    has $.path-expr;

    has $.text;

    submethod TWEAK {
        self.gist;
    }

    method gist {
        $.path-expr.gist
    }
}

our class ExprTry {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

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

our class ExprTupleIndex {
    has $.lit-int is required;

    has $.text;

    method gist {
        ".{$.lit-int.gist}"
    }
}

our class ExprVec {
    has $.vec-expr;

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

our class ExprParen {
    has $.maybe-exprs;

    has $.text;

    submethod TWEAK {
        self.gist;
    }

    method gist {
        "(" ~ $.maybe-exprs>>.gist.join(", ") ~ ")"
    }
}

our class ExprAgain {
    has $.lifetime;
    has $.ident;

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

our class ExprRet {
    has $.expr;

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

our class ExprBreak {
    has $.ident;
    has $.lifetime;

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

our class ExprYield {
    has $.expr;

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

our class ExprAssign {
    has $.expr;
    has $.expr-nostruct;

    has $.text;

    submethod TWEAK {
        self.gist;
    }

    method gist {
        if $.expr {
            " = {$.expr.gist}"
        } else {
            " = {$.expr-nostruct.gist}"
        }
    }
}

our class ExprAssignShl {
    has $.nonblock-expr;
    has $.expr;
    has $.expr-nostruct;

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

our class ExprAssignShr {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

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

our class ExprAssignSub {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

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

our class ExprAssignAdd {
    has $.expr;

    has $.text;

    method gist {
        "+= {$.expr.gist}"
    }
}

our class ExprAssignBitAnd {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

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

our class ExprAssignBitOr {
    has $.nonblock-expr;
    has $.expr;
    has $.expr-nostruct;

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

our class ExprAssignBitXor {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

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

our class ExprAssignRem {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

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

our class ExprBinary {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

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

our class ExprOrOr {
    has $.expr;

    has $.text;

    method gist {
        " || {$.expr.gist}"
    }
}

our class ExprAndAnd {
    has $.expr;

    has $.text;

    method gist {
        " && {$.expr.gist}"
    }
}

our class ExprEqEq {
    has $.expr;

    has $.text;

    method gist {
        " == {$.expr.gist}"
    }
}

our class ExprNe {
    has $.expr;

    has $.text;

    method gist {
        " != {$.expr.gist}"
    }
}

our class ExprLt {
    has $.expr;

    has $.text;

    method gist {
        " < {$.expr.gist}"
    }
}

our class ExprGt {
    has $.expr;

    has $.text;

    method gist {
        " > {$.expr.gist}"
    }
}

our class ExprLe {
    has $.expr;

    has $.text;

    method gist {
        " <= {$.expr.gist}"
    }
}

our class ExprGe {
    has $.expr;

    has $.text;

    method gist {
        " >= {$.expr.gist}"
    }
}

our class ExprPipe {
    has $.expr;

    has $.text;

    method gist {
        " | {$.expr.gist}"
    }
}

our class ExprCaret {
    has $.expr;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        " ^ {$.expr.gist}"
    }
}

our class ExprAmp {
    has $.expr;

    has $.text;

    method gist {
        " & {$.expr.gist}"
    }
}

our class ExprShl {
    has $.expr;

    has $.text;

    method gist {
        " << {$.expr.gist}"
    }
}

our class ExprShr {
    has $.expr;

    has $.text;

    method gist {
        " >> {$.expr.gist}"
    }
}

our class ExprPlus {
    has $.expr;

    has $.text;

    method gist {
        " + {$.expr.gist}"
    }
}

our class ExprMinus {
    has $.expr;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        " - {$.expr.gist}"
    }
}

our class ExprStar {
    has $.expr;

    has $.text;

    method gist {
        " * {$.expr.gist}"
    }
}

our class ExprSlash {
    has $.expr;

    has $.text;

    method gist {
        " / {$.expr.gist}"
    }
}

our class ExprMod {
    has $.expr;

    has $.text;

    method gist {
        " % {$.expr.gist}"
    }
}

our class ExprRange {
    has $.expr;

    has $.text;

    method gist {
        "..{$.expr.gist}"
    }
}

our class ExprCast {
    has $.ty;

    has $.text;

    method gist {
        "as {$.ty.gist}"
    }
}

our class ExprTypeAscr {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
    has $.ty;

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

our class ExprBox {
    has $.expr;

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

our class Expr {
    has @.prefix;
    has $.base;
    has @.tail;

    has $.text;

    submethod TWEAK {
        self.gist;
    }

    method gist {
        my $prefix = @.prefix>>.gist.join("");
        my $base   = $.base.gist;
        my $tail   = @.tail>>.gist.join("");
        $prefix ~ $base ~ $tail
    }
}

our class ExprStruct {
    has $.path-expr;
    has $.struct-expr-fields;

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

our class ExprAssignMul {
    has $.nonblock-expr;
    has $.expr;
    has $.expr-nostruct;

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

our class ExprAssignDiv {
    has $.expr;
    has $.nonblock-expr;
    has $.expr-nostruct;

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

our class ExprUnaryMinus {
    has $.expr;

    has $.text;

    method gist {
        my $expr = $.expr.gist;
        "-$expr"
    }
}

our class ExprUnaryNot {
    has $.expr;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        my $expr = $.expr.gist;
        "!$expr"
    }
}

our class ExprUnaryStar {
    has $.expr;

    has $.text;

    method gist {
        "*{$.expr.gist}"
    }
}

our class Exprs {
    has $.expr;

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

our class Self {

    has $.text;

    method gist {
        "self"
    }
}
