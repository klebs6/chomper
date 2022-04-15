role GlobalSubparse {
    method subparse($string, :$actions, :global(:$g)) {
		return callsame unless $g;
		my $pos = 0;
		my @matches;
		while $pos < $string.chars {
			my $match = self.subparse($string, :$pos, :$actions);
			if $match {
				@matches.push: $match;
				$pos = $match.to;
			} else { $pos++ }
		}
		@matches
	}
}
