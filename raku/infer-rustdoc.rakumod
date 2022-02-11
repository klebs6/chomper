
our sub get-field-bodies($index,%struct) {
    #only gets the ones rustdoc does not strip

    my @fields = %struct<inner><fields>.List;

    my @field-bodies = do for @fields {
        $index{$_}
    };

    @field-bodies
}

our sub get-impl-bodies($index,%struct) {
    my @impls = %struct<inner><impls>.List;

    my @impl-bodies = do for @impls {
        $index{$_}
    };

    @impl-bodies
}

our sub remove-type-arrays(%model) {
    for %model.List {
        my $attrib-name = $_.keys.sort[0];
        %model{$attrib-name}<types>:delete;
    }
}

our sub follow-struct-links($index, %items) {
    for %items<struct>.List>>.Hash -> %struct {
        %struct<inner><fields> = get-field-bodies($index,%struct);
        %struct<inner><impls>  = get-impl-bodies($index,%struct);
    }
}
