use case;

#for struct/enum
our sub format-name($name) {

    my $strip-tails = token {
        [
            | _T
            | _t
            | _S
            | _s
        ]
        $
    };

    my $result = $name;

    if $name.contains($strip-tails) {
        my @matches = $name ~~ $strip-tails;
        my $idx = @matches[0].from;
        $result = $name.substr(0,$idx);
    }

    my @pop-members = [
        (regex { func <!before [ tor | tion ]> }, "func" ),
        (regex { dict <!before [ ionary ]> }, "dict"),
        (regex { expr <!before [ ession ]> }, "expr"),
        (regex { script  }, "script"),
        (regex { for  }, "for"),
        (regex { fold  }, "fold"),
        (regex { info  }, "info"),
    ];

    for @pop-members {
        if $result ~~ $_[0] {
            $result = $result.subst($_[1], "{$_[1]}_");
        }
    }

    snake-to-camel($result).chomp.trim
}
