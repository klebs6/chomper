use util;
use grammar;

our class OperatorCompare {

    has @.comments;
    has Bool $.inline;
    has      $.op0,
    has      $.op1,

    submethod BUILD(Match :$submatch, Str :$user-class) {

        @!comments = 
        get-rcomments-list($submatch);

        $!inline   = 
        get-rinline-b($submatch);

        $!op0      = $user-class 
        ?? $user-class 
        !! get-roperand($submatch,0);

        $!op1 = $user-class 
        ?? get-roperand($submatch,0) 
        !! get-roperand($submatch,1);

        $!op1 = get-naked($!op1);
    }

    method maybe-inline {
        $!inline ?? "#[inline] " !! ""
    }

    method format-comment {
        format-rust-comments(@!comments)
    }

    method translate-op-ord($body) {

        qq:to/END/;
        impl Ord<{$!op1}> for $!op0 \{
            {self.format-comment}
            {self.maybe-inline}fn cmp(&self, other: &$!op1) -> Ordering \{
                todo!();
                /*
                {$body.trim.chomp.indent(4)}
                */
            \}
        \}

        impl PartialOrd<{$!op1}> for $!op0 \{
            {self.maybe-inline}fn partial_cmp(&self, other: &$!op1) -> Option<Ordering> \{
                Some(self.cmp(other))
            \}
        \}
        END
    }

    method translate-partial-eq($body) {

        qq:to/END/;
        impl PartialEq<{$!op1}> for $!op0 \{
            {self.format-comment}
            {self.maybe-inline}fn eq(&self, other: &$!op1) -> bool \{
                todo!();
                /*
                {$body.trim.chomp.indent(4)}
                */
            \}
        \}

        {if $!op0 ~~ $!op1 {
            "impl Eq for $!op0 \{\}"
        }else {
            ""
        }}
        END
    }

    our sub mock {
        OperatorCompare.new(
            comments => ('//here is a comment'), 
            inline   => True,
            op0      => 'f64',
            op1      => 'f32',
        )
    }
}

our sub translate-op-eq($submatch, $body, $rclass) {
    my $parsed = OperatorCompare.new(:$submatch, user-class => $rclass);
    $parsed.translate-partial-eq($body)
}

our sub translate-op-lt($submatch, $body, $rclass) {
    my $parsed = OperatorCompare.new(:$submatch, user-class => $rclass);
    $parsed.translate-op-ord($body)
}
