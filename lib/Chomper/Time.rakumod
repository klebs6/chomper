
our sub last-midnight {

    my $hours = DateTime.now.hour < 5 ?? 48 !! 24;

    my $ayer = DateTime.now.earlier(hours => $hours);

    DateTime.new(
        day    => $ayer.day,
        year   => $ayer.year,
        month  => $ayer.month,
        hour   => 23,
        minute => 59,
    )
}

our sub today-at-three-am {

    DateTime.new(
        day    => DateTime.now.day,
        year   => DateTime.now.year,
        month  => DateTime.now.month,
        hour   => 3,
        minute => 0,
    )
}

our sub yesterday-at-three-am {

    DateTime.new(
        day    => DateTime.now.day - 1,
        year   => DateTime.now.year,
        month  => DateTime.now.month,
        hour   => 3,
        minute => 0,
    )
}
