our sub get-is-unique($ident)        { $ident<nonvector-identifier><unique-ptr>:exists }
our sub get-is-c10-optional($ident)  { $ident<nonvector-identifier><c10-optional>:exists }
our sub get-is-list($ident)          { $ident<nonvector-identifier><std-list>:exists }
our sub get-is-shared($ident)        { $ident<nonvector-identifier><shared-ptr>:exists }
our sub get-is-template($ident)      { $ident<nonvector-identifier><template-identifier>:exists }
our sub get-is-set($ident)           { $ident<nonvector-identifier><std-set>:exists }
our sub get-is-deque($ident)         { $ident<nonvector-identifier><std-deque>:exists }
our sub get-is-bit-set($ident)       { $ident<nonvector-identifier><bit-set>:exists }
our sub get-is-unordered-set($ident) { $ident<nonvector-identifier><unordered-set>:exists }
our sub get-is-unordered-map($ident) { $ident<nonvector-identifier><unordered-map>:exists }
our sub get-is-pair($ident)          { $ident<nonvector-identifier><std-pair>:exists }

our sub vectorize-rtype($rtype-base, $vector-levels is rw) {

    my $result = $rtype-base;

    while $vector-levels > 0 {
        $vector-levels -= 1;
        $result = "Vec<{$result}>";
    }

    $result;
}

our sub get-vector-levels($ident is rw) {

    my $vector-levels = 0;

    while $ident<vectorized-identifier>:exists {
        $vector-levels++;
        $ident = $ident<vectorized-identifier><maybe-vectorized-identifier>;
    }

    $vector-levels
}

our class TypeInfo {

    has Str  $.cpp-type         is required;
    has Str  $.template-parent  is required;
    has Int  $.vector-levels    is required;
    has Bool $.is-unique        is required;
    has Bool $.is-list          is required;
    has Bool $.is-set           is required;
    has Bool $.is-pair          is required;
    has Bool $.is-shared        is required;
    has Bool $.is-deque         is required;
    has Bool $.is-bit-set       is required;
    has Bool $.is-c10-optional  is required;
    has Bool $.is-unordered-set is required;
    has Bool $.is-unordered-map is required;
    has Bool $.is-template      is required;
    has Str  $.pairing = Nil; 

    method vectorized-rtype {

        my $rtype-base = %*typemap{$!cpp-type};

        if $!is-unique {
            $rtype-base = "Box<{$rtype-base}>";
        }

        if $!is-list {
            $rtype-base = "LinkedList<{$rtype-base}>";
        }

        if $!is-set {
            $rtype-base = "HashSet<{$rtype-base}>";
        }

        if $!is-deque {
            $rtype-base = "VecDeque<{$rtype-base}>";
        }

        if $!is-c10-optional {
            $rtype-base = "Option<{$rtype-base}>";
        }

        if $!is-bit-set {
            $rtype-base = "BitSet<{$rtype-base}>";
        }

        if $!is-unordered-set {
            $rtype-base = "HashSet<{$rtype-base}>";
        }

        if $!is-unordered-map {
            my $p1 = %*typemap{$!cpp-type};
            my $p2 = %*typemap{$!pairing};
            say $!cpp-type;
            say $!pairing;
            exit;
            $rtype-base = "HashMap<{$p1}, {$p2}>";
        }

        if $!is-template {
            my $rtype-parent = %*typemap{$!template-parent};
            $rtype-base = "{$rtype-parent}<{$rtype-base}>";
        }

        if $!is-pair {
            my $p1 = %*typemap{$!cpp-type};
            my $p2 = %*typemap{$!pairing};
            $rtype-base = "($p1, $p2)";
        }

        if $!is-shared {
            $rtype-base = "Arc<{$rtype-base}>";
        }

        vectorize-rtype($rtype-base, $!vector-levels)
    }
}

our sub populate-typeinfo($ident is rw) {

    my $vector-levels = get-vector-levels($ident);

    my Bool $is-unique        = get-is-unique($ident);
    my Bool $is-list          = get-is-list($ident);
    my Bool $is-set           = get-is-set($ident);
    my Bool $is-pair          = get-is-pair($ident);
    my Bool $is-shared        = get-is-shared($ident);
    my Bool $is-deque         = get-is-deque($ident);
    my Bool $is-bit-set       = get-is-bit-set($ident);
    my Bool $is-c10-optional  = get-is-c10-optional($ident);
    my Bool $is-unordered-set = get-is-unordered-set($ident);
    my Bool $is-unordered-map = get-is-unordered-map($ident);
    my Bool $is-template      = get-is-template($ident);

    my $pairing         = "";
    my $template-parent = "";

    my @one-hot = [
        ($is-unique, {

        })

    ];

    my $cpp-type = do given (
        $is-unique, 
        $is-list, 
        $is-set, 
        $is-pair, 
        $is-shared, 
        $is-deque,
        $is-c10-optional,
        $is-bit-set,
        $is-unordered-set,
        $is-template,
        $is-unordered-map,
        ) {

        when (:so, :not, :not, :not, :not, :not, :not, :not, :not, :not, :not) {
            $ident<nonvector-identifier><unique-ptr><nonvector-identifier>.Str
        }
        when (:not, :so, :not, :not, :not, :not, :not, :not, :not, :not, :not) {
            $ident<nonvector-identifier><std-list><nonvector-identifier>.Str
        }
        when (:not, :not, :so, :not, :not, :not, :not, :not, :not, :not, :not) {
            $ident<nonvector-identifier><std-set><nonvector-identifier>.Str
        }
        when (:not, :not, :not, :so, :not, :not, :not, :not, :not, :not, :not) {
            $pairing = 
            $ident<nonvector-identifier><std-pair><nonvector-identifier>[1].Str;
            $ident<nonvector-identifier><std-pair><nonvector-identifier>[0].Str
        }
        when (:not, :not, :not, :not, :so, :not, :not, :not, :not, :not, :not) {
            $ident<nonvector-identifier><shared-ptr><nonvector-identifier>.Str
        }
        when (:not, :not, :not, :not, :not, :so, :not, :not, :not, :not, :not) {
            $ident<nonvector-identifier><std-deque><nonvector-identifier>.Str
        }
        when (:not, :not, :not, :not, :not, :not, :so, :not, :not, :not, :not) {
            $ident<nonvector-identifier><c10-optional><nonvector-identifier>.Str
        }
        when (:not, :not, :not, :not, :not, :not, :not, :so, :not, :not, :not) {
            $ident<nonvector-identifier><bit-set><nonvector-identifier>.Str
        }
        when (:not, :not, :not, :not, :not, :not, :not, :not, :so, :not, :not) {
            $ident<nonvector-identifier><unordered-set><nonvector-identifier>.Str
        }
        when (:not, :not, :not, :not, :not, :not, :not, :not, :not, :so, :not) {
            $template-parent = $ident<nonvector-identifier><template-identifier><identifier>.Str;
            $ident<nonvector-identifier><template-identifier><nonvector-identifier>.Str
        }
        when (:not, :not, :not, :not, :not, :not, :not, :not, :not, :not, :so) {
            my $ty0 = $ident<nonvector-identifier><unordered-map><type>[0].Str.trim;
            my $ty1 = $ident<nonvector-identifier><unordered-map><type>[1].Str.trim;
            $pairing = $ty1;
            $ty0
        }
        when (:not, :not, :not, :not, :not, :not, :not, :not, :not, :not, :not) {
            $ident<nonvector-identifier>.Str
        }
        default { die "unreachable"; }
    };

    TypeInfo.new(
        cpp-type         => $cpp-type,
        template-parent  => $template-parent,
        vector-levels    => $vector-levels,
        is-unique        => $is-unique,
        is-c10-optional  => $is-c10-optional,
        is-list          => $is-list,
        is-set           => $is-set,
        is-pair          => $is-pair,
        is-shared        => $is-shared,
        is-deque         => $is-deque,
        is-bit-set       => $is-bit-set,
        is-unordered-set => $is-unordered-set,
        is-unordered-map => $is-unordered-map,
        is-template      => $is-template,
        pairing          => $pairing,
    )
}
