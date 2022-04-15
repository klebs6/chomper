use Chomper::ReformatBlockComment;
use Chomper::BlockComment;
use Chomper::Util;
use Chomper::TypeInfo;
use Chomper::Comments;
use Chomper::LineCommentToBlockComment;
use Chomper::WrapBodyTodo;

our role Operator does CanGetDocComments {

    has $.assign is required;
    has $.trait  is required;
    has $.fn     is required;

    has Bool $.inline = False;
    has Str  $.out is required;
    has ParenthesizedArgs $.args is required;
    has Str $.namespace;
    has Str $.body;

    submethod BUILD(
        Match :$submatch, 
        Str :$body, 
        :$rclass,
        Bool :$assign,
        :$trait,
        :$fn) {

            self.init-can-get-doc-comments(:$submatch);
        $!inline        = so get-rinline($submatch);
        $!out           = get-rust-return-type($submatch, augment => False);
        $!args          = ParenthesizedArgs.new(
            parenthesized-args => $submatch<parenthesized-args>,
        );
        $!namespace = ($rclass and $rclass !~~ "X")  ?? $rclass !! ~$submatch<namespace><identifier>;
        $!body   = $body;
        $!assign = $assign;
        $!trait  = $trait;
        $!fn     = $fn;
    }

    method gist {
        self.stamp($!trait,$!fn, $!assign)
    }


    method stamp($trait, $fn, Bool $assign) {

        my $rinline = $!inline ?? '#[inline]' !! '';
        my $self    = $!assign ?? "&mut self" !! "self";
        my $rhs     = $!args.type-for-arg-at-index(0);

        qq:to/END/;
        impl {$trait}<{$rhs}> for $!namespace \{

            {$assign ?? "" !! "type Output = $!out;"}
            {self.get-doc-comments}
            {$rinline}fn {$fn}($self, other: &$rhs) -> Self::Output \{
                {wrap-body-todo($!body)}
            \}
        \}
        END
    }
}
