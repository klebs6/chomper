use reformat-block-comment;
use block-comment;
use util;
use type-info;
use line-comment-to-block-comment;

our role Operator {

    has Str $.line-comment;
    has Str $.block-comment;
    has Bool $.inline = False;
    has Str  $.out is required;
    has ParenthesizedArgs $.args is required;
    has Str $.namespace;
    has Str $.body;

    submethod BUILD( Match :$submatch, Str :$body, :$rclass) {
        $!line-comment  = format-rust-comments(get-rcomments-list($submatch));
        $!block-comment = ~$submatch<block-comment>;
        $!inline        = so get-rinline($submatch);
        $!out           = get-rust-return-type($submatch, augment => False);
        $!args          = ParenthesizedArgs.new(
            parenthesized-args => $submatch<parenthesized-args>,
        );
        $!namespace = ($rclass and $rclass !~~ "X")  ?? $rclass !! ~$submatch<namespace><identifier>;
        $!body = $body;
    }

    method get-doc-comments {

        if $!block-comment {
            return reformat-block-comment($!block-comment);
        }

        $!line-comment
    }

    method stamp($trait, $fn) {

        my $rinline = $!inline ?? '#[inline]' !! '';
        my $rhs = $!args.type-for-arg-at-index(0);

        qq:to/END/;
        impl {$trait}<{$rhs}> for $!namespace \{

            type Output = $!out;

            {self.get-doc-comments}
            {$rinline}fn {$fn}(self, other: &$rhs) -> Self::Output \{
                todo!();
                /*
                {$!body.trim.chomp.indent(4)}
                */
            \}
        \}
        END
    }
}

our class OperatorAdd does Operator {
    has $.trait = "Add";
    has $.fn    = "add";

    method gist {
        self.stamp($!trait,$!fn)
    }
}

our class OperatorSub does Operator {
    has $.trait = "Sub";
    has $.fn    = "sub";

    method gist {
        self.stamp($!trait,$!fn)
    }
}

our class OperatorMul does Operator {
    has $.trait = "Mul";
    has $.fn    = "mul";

    method gist {
        self.stamp($!trait,$!fn)
    }
}

our class OperatorDiv does Operator {
    has $.trait = "Div";
    has $.fn    = "div";

    method gist {
        self.stamp($!trait,$!fn)
    }
}
