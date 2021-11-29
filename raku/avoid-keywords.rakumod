our sub avoid-keywords($s) {

    my %bad = %(
        loop  => "loop_",
        try   => "try_",
        move  => "move_",
        copy  => "copy_",
        type  => "ty",
        in    => "in_",
        match => "match_",
        impl  => "impl_",
        self  => "self_",
        str   => "str_",
        ref   => "ref_",
        box   => "box_",
        fn    => "fn_",
        pub   => "pub_",
        where => "where_",
        as    => "as_",
        async => "async_",
        yield => "yield_",
        use   => "use_",
        priv  => "priv_",
    );

    %bad{$s} // $s
}
