use Chomper::Util;
use Chomper::Grammar;
use Chomper::Comments;
use Chomper::TypeInfo;
use Chomper::WrapBodyTodo;

our role OperatorCompare does CanGetDocComments {

    has ParenthesizedArgs $.args;
    has $.namespace;
    has $.body;
    has Bool $.inline;
    has $.tags = ();
    has Bool $.op-eq;

    submethod BUILD(Match :$submatch, Str :$user-class, Str :$body) {

        self.init-can-get-doc-comments(:$submatch);
        $!inline        = get-rinline-b($submatch);
        $!tags          = get-rtags($submatch);

        $!args          = ParenthesizedArgs.new(
            parenthesized-args => $submatch<parenthesized-args>,
        );

        $!namespace = ($user-class.Bool and $user-class !~~ "X")  
        ?? $user-class 
        !! ~$submatch<namespace><identifier>;

        $!body   = $body;
    }

    method maybe-inline {
        $!inline ?? "#[inline] " !! ""
    }

    method get-rhs {
        get-naked(
            $!args.type-for-arg-at-index(0)
        )
    }
}

our class OperatorEq does OperatorCompare {

    method gist {

        my  $rhs = self.get-rhs();

        qq:to/END/;
        impl PartialEq<{$rhs}> for $!namespace \{
            {self.get-doc-comments}
            {self.tags}
            {self.maybe-inline}fn eq(&self, other: &$rhs) -> bool \{
                {wrap-body-todo($!body)}
            \}
        \}

        {if $!namespace ~~ $rhs {
            "impl Eq for $!namespace \{\}"
        }else {
            ""
        }}
        END
    }
}

our class OperatorOrd does OperatorCompare {

    method gist {

        my  $rhs = self.get-rhs();

        qq:to/END/;
        impl Ord<{$rhs}> for $!namespace \{
            {self.get-doc-comments}
            {self.tags}
            {self.maybe-inline}fn cmp(&self, other: &$rhs) -> Ordering \{
                {wrap-body-todo($!body)}
            \}
        \}

        impl PartialOrd<{$rhs}> for $!namespace \{
            {self.tags}
            {self.maybe-inline}fn partial_cmp(&self, other: &$rhs) -> Option<Ordering> \{
                Some(self.cmp(other))
            \}
        \}
        END
    }
}

our sub translate-op-eq($submatch, $body, $rclass) {
    OperatorEq.new(
        :$submatch, 
        user-class => $rclass,
        :$body
    ).gist
}

our sub translate-op-lt($submatch, $body, $rclass) {
    OperatorOrd.new(
        :$submatch, 
        user-class => $rclass,
        :$body
    ).gist
}
