role Subgrammar[::G :$grammar, :$actions] {
    multi method slag(G) {
        my $old-actions = self.actions;
        self.set_actions: $actions;

        my @wrapped = G.^methods(:local).map: -> &m {
            with self.^methods.first({.name eq &m.name}) {
                next if $_ === &m or .name eq 'BUILDALL';
                .wrap: method (|c) { m self, |c } }
        }

        LEAVE { .restore for @wrapped;
                self.set_actions: $old-actions }
        self.TOP
    }
}

sub pretty($_, :$nl=False) {
    when Pair { .key, pretty(.value, :nl) }
    when Str  { .raku }
    when Map  -> :@_ = .map(&pretty) {
        my $n = @_»[0]».chars.max+1;
        with [ @_.map({.fmt: "\%-{$n}s", '=> '})».trim.sort(&[lt]).join(",\n").indent: $nl ?? 4 !! 2 ] 
        {
            '{' ~ ($nl ?? "\n$_" !! " {.trim}") ~ '}' 
        }
    }
}
