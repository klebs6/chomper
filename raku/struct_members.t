our sub test-rust-struct-members {
    my $test = RustStructMembers.new(members => [
        RustStructMember.new(
            name    => "enable_broadcast",
            type    => "bool",
            default => "false",
            comments => [
                "// here is a test comment",
                "// and another",
            ],
        ),
        RustStructMember.new(
            name    => "axis_str",
            type    => "String",
            default => "something",
        ),
        RustStructMember.new(
            name    => "enable_broadcast_some_long_name",
            type    => "bool",
            comments => [
                "// here is another test comment",
                "// and another",
                "// and another",
            ],

        ),
        RustStructMember.new(
            name    => "x",
            type    => "i32",
        ),
    ]);
    say $test.gist;
}


