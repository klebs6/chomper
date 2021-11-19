
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
