use JSON::Fast;
use Data::Dump::Tree;

use Chomper::Crates;

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

our sub create-json-classes(%merged) {

    for %merged.keys.sort {

        my $exemplar = %merged{$_};

        my $name = $_;
        $name ~~ s:g/_(.)/{$0.tc}/;

        say JSON::Infer::infer(
            content    => $exemplar,
            class-name => $name.tc,
            kebab      => False
        ).make-class;
    }
}

our sub json-db-file($crate) {
    "./target/doc/{$crate.subst('-','_')}.json"
}

our sub get-content($crate) {
    my $file = json-db-file($crate);

    my $content = $file.IO.slurp;

    if not $content {
        say "empty content for crate $crate";
        return Nil;
    }

    $content
}

our sub type-str($type) {

    do given $type {
        when Hash { "Hash" } 
        when List { "List" } 
        when Str  { "Str"  } 
        when Bool { "Bool" } 
        when Int  { "Int"  } 
        when Num  { "Num"  } 
        when Any  { die "should not get here"; }
    }
}

our sub get-json-index($crate) {
    my $content = get-content($crate);

    $content ?? from-json($content)<index> !! Nil
}

our sub check-type-consistency(@types) {
    my $first = @types[0];
    so @types.map({ $_ ~~ $first }).all
}

#`(want to check we dont, for example, have a value
which is sometimes a type and sometimes an int)
our sub mark-type-inconsistent-attribs(%model) {
    my @attribs = %model.keys.sort;

    for @attribs -> $attrib {
        my @types = %model{$attrib}<types>.List;
        %model{$attrib}<marked> = not so check-type-consistency(@types);
    }
}

our sub get-items-from-index($index) {
    categorize { .Hash<kind> }, do for $index.List {
        my $item-body = $_.kv[1].List;
        $item-body
    }
}

our sub create-model($kind, @items-of-kind) {

    my %model;
    for @items-of-kind -> $item {
        for $item.List.sort -> $attrib {

            my $attrib-name = $attrib.kv[0];

            die if not $attrib-name ~~ Str;

            #if $attrib-name ~~ /inner/ { $attrib-name = $kind ~ "_inner"; }

            my $attrib-value      = $attrib.kv[1];

            if $attrib-value {

                %model{$attrib-name}<types>.push:  type-str($attrib-value.WHAT);
                %model{$attrib-name}<values>.push: $attrib-value;
            }
        }
    }

    mark-type-inconsistent-attribs(%model);

    condense(%model)
}

our sub condense(%attrib-map, :$print = False) {

    my %condensed;

    my sub put($attrib-name,@attrib-values) {

        die if not check-type-consistency(@attrib-values>>.WHAT);

        my $example-val   = @attrib-values.List[0];
        my $type          = $example-val.WHAT;

        do given $type {

            when Hash {
                %condensed{$attrib-name} = create-model($attrib-name, @attrib-values);
            }

            when Str | Int | Num | Bool {
                %condensed{$attrib-name} = $example-val;
            }

            when List {

                my @l-type = do for @attrib-values -> $list {
                    my @t  = do for $list.List { $_.WHAT };
                    die if not check-type-consistency(@t);
                    my @ts = do for $list.List { type-str($_.WHAT) };
                    @ts
                };

                #checks type consistency across
                #full set 
                die if not @l-type>>.Slip.flat.squish.elems eq 1;

                #say "need handle $attrib-name";
                %condensed{$attrib-name} = $example-val;
            }

            when Any {
                die "need handle this";
            }
        }
    }

    my @attrib-names = %attrib-map.keys.sort;

    for @attrib-names -> $attrib-name {

        my $item          = %attrib-map{$attrib-name};

        my @attrib-values = $item<values>.List;
        my @types         = $item<types>.List;
        my $marked        = $item<marked>.Bool;

        do if check-type-consistency(@types) {
            put($attrib-name, @attrib-values);

        } else {

            @types Z @attrib-values ==> sort({
                my @a = $^a.List;
                my @b = $^b.List;
                @a[1] = to-json(@a[1]); 
                @b[1] = to-json(@b[1]); 
                @a cmp @b
            }) ==> my @zipped;

            my %by-type = categorize {$_[0]}, @zipped;

            my @keys = %by-type.keys;

            for @keys {
                my @items    = %by-type{$_}.List.map: {$_[1]};
                my $alt-name = $attrib-name ~ "_" ~ $_.lc;
                put($alt-name, @items);
            }
        }
    }

    if $print {
        say "-------------------";
        ddt %attrib-map;
        ddt %condensed, :!color;
    }

    %condensed
}

our sub create-paradigm-map-for-crate($crate) {

    my $index = get-json-index($crate);

    return if not $index;

    my %items = get-items-from-index($index);

    my @kinds = %items.keys.sort;

    my %golden = do for @kinds -> $kind {

        my @items-of-kind = %items{$kind}.List>>.Hash;

        $kind => create-model($kind, @items-of-kind)
    };

    %golden
}

our sub merge-paradigm-maps(@paradigm-maps) {

    my %map;

    for @paradigm-maps {
        if $_ {
            my %crate-map = $_.Hash;
            my @kinds = %crate-map.keys.sort;
            for @kinds -> $kind {
                my $exemplar = %crate-map{$kind};
                %map{$kind}<values>.push: $exemplar;
                %map{$kind}<types>.push:  type-str($exemplar.WHAT);
            }
        }
    }

    mark-type-inconsistent-attribs(%map);

    condense(%map)
}
