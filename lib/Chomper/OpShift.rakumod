use Chomper::Util;
use Chomper::WrapBodyTodo;

our sub translate-op-shift($submatch, $body, $rclass, :$left) {

    my ( 
        $rcomments-list,
        $rinline, 
        $return-type, 
        $roperand0,
        $roperand1, 
        $tags
    ) 
    = rparse-operator($submatch, $rclass);

    my $rcomment = format-rust-comments($rcomments-list);

    my $sigil = $left ?? "Shl" !! "Shr";

    qq:to/END/;
    impl {$sigil}<{$roperand1}> for $roperand0 \{
        type Output = $return-type;

        $rcomment
        {$tags}
        {$rinline}fn {$sigil.lc}(self, rhs: $roperand1) -> Self::Output \{
            {wrap-body-todo($body)}
        \}
    \}
    END
}

our sub translate-op-shift-assign($submatch, $body, $rclass, :$left) {

    my ( 
        $rcomments-list,
        $rinline, 
        $rtype, 
        $roperand,
        $rfunction-args-list, 
        $tags
    ) 
    = rparse-operator-assign($submatch);

    my $rcomment = format-rust-comments($rcomments-list);

    my $sigil = $left ?? "Shl" !! "Shr";

    qq:to/END/;
    impl {$sigil}Assign<{$roperand}> for $rtype \{
        $rcomment
        {$tags}
        {$rinline}fn {$sigil.lc}_assign(&mut self, {$rfunction-args-list}) \{
            {wrap-body-todo($body)}
        \}
    \}
    END
}

our sub translate-op-shl($submatch, $body, $rclass) {
    translate-op-shift($submatch, $body, $rclass, left => True);
}

our sub translate-op-shl-assign($submatch, $body, $rclass) {
    translate-op-shift-assign($submatch, $body, $rclass, left => True);
}

our sub translate-op-shr($submatch, $body, $rclass) {
    translate-op-shift($submatch, $body, $rclass, left => False);
}

our sub translate-op-shr-assign($submatch, $body, $rclass) {
    translate-op-shift-assign($submatch, $body, $rclass, left => False);
}
