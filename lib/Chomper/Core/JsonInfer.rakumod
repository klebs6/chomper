unit package JSON::Infer;

use JSON::Fast;
use HTTP::UserAgent;

role Classes        { ... }
role Types          { ... }
class Attribute     { ... }
class Class         { ... }
class Type          { ... }

class X::Infer is Exception {
    has Str         $.message         is rw;
    has Str         $.uri             is rw;
    has Exception   $.inner-exception is rw;
}

class Type {
    has Str     $.name       is rw;
    has Str     $.subtype-of is rw handles(has-subtype => 'defined');
    has Bool    $.array      is rw = False;
    has Class   $.of-class   is rw;
}

class Class {

    has Bool      $.inner-class  = False;
    has Bool      $.kebab        = False;
    has Str       $.name       is rw;
    has Bool      $.top-level  is rw = False;
    has Attribute %.attributes is rw;

    has @.classes is rw;
    has @.types   is rw;

    method new-from-data(
        :$class-name, 
        :$content, 
        Bool :$inner-class = False, 
        Bool :$kebab = False --> Class ) 
    {
        my $obj = self.new(name => $class-name, :$inner-class, :$kebab);

        for $content.List -> $datum {
            #say $datum.WHAT;
            $obj.populate-from-data($datum);
        }

        $obj;
    }

    method populate-from-data($datum) {

        return if not $datum;

        my sub process(Pair $x) {
            my $key = $datum.kv[0];
            my $val = $datum.kv[1];

            if not %!attributes{$key}:exists {
                my $attr = Attribute.new-from-value(
                    $key, 
                    $val, 
                    $!name, 
                    $!inner-class, 
                    :$!kebab
                );

                %!attributes{$attr.name} = $attr;
                self.add-classes($attr);
                self.add-types($attr);
            }
        }

        given $datum.WHAT {
            when Pair {
                process($datum)
            }
            when Hash {
                for $datum.kv -> $pair {
                    process($pair)
                }
            }
            when Array {
                die unless $datum.elems eq 2;
                process($datum.pairup[0])
            }
            default {
                say $datum.WHAT;
                say $datum;
                die "handle this.  curious what it is";
            }
        }
    }

    method add-classes(Mu:D $object) {

        for $object.classes -> $class {
            if !?@!classes.grep({$class.name eq $_.name}) {
                @!classes.push($class);
            }
        }

        if $object ~~ Class { 
            @!classes.push($object); 
        }
    }

    method  add-types(Mu:D $object ) {

        for $object.types -> $type {
            @!types.push($type);
        }

        if $object ~~ Type {
            @!types.push($object);
        }
    }

    multi method make-class(Int $level  = 0 --> Str ) {
        my $indent = "    " x $level;
        my Str $ret;

        if $!top-level {
            $ret ~= "\n{ $indent }use JSON::Name;\n{ $indent }use JSON::Class;\n";
        }

        $ret ~= $indent ~ "class { self.name } does JSON::Class \{";
        my $next-level = $level + 1;

        for self.classes -> $class {
            $ret ~= "\n" ~ $class.make-class($next-level);
        }

        for self.attributes.kv -> $name, $attr {
            $ret ~= "\n" ~ $attr.make-attribute($next-level) ;
        }

        $ret ~= "\n$indent\}";
        $ret;
    }
}

class Attribute {

    has Str $.name      is rw;
    has Str $.raku-name is rw;

    has Bool $.is-array     = False;
    has Bool $.inner-class  = False;
    has Bool $.kebab        = False;

    has Str $.type-constraint  is rw;
    has Str $.class            is rw;
    has Str $.child-class-name is rw;

    has @.classes is rw;
    has @.types   is rw;

    method new-from-value(
        Str $name, 
        $value, 
        $class, 
        Bool $inner-class = False, 
        Bool :$kebab = False --> Attribute ) 
    {
        my $obj = self.new(:$name, :$class, :$inner-class, :$kebab );
        $obj.infer-from-value(parent => $name, :$value);
        $obj;
    }

    method infer-from-value(:$parent, :$value)
    {
        my $type_constraint;

        given $value {
            when Array {

                $!is-array = True;

                if ?$_.grep(Array|Hash) {
                    my $obj = self.process-object(:$parent, value => $_);
                    $type_constraint = $obj.name;

                } else {

                    $type_constraint = '';
                }
            }
            when Hash {
                my $obj = self.process-object(:$parent, value => $_);
                $type_constraint = $obj.name;

            }
            default {
                $type_constraint = $_.WHAT.^name;
            }
        }

        $!type-constraint = $type_constraint;
    }

    method process-object(:$parent, :$value) {
        my %data = do if $value ~~ List {

            do given $parent {
                when /inputs/ {
                    my $first = $value.list[0];
                    my $name  = $first[0];
                    my $body  = $first[1];

                    %( class-name  => "Input", 
                       content     => $body )
                }
                when /inner_list/ {

                    my $first = $value.list[0];
                    my $name  = $first[0];
                    my $body  = $first[1];

                    %( class-name  => "InnerList", 
                       content     => $body )
                }
                when /args/ {

                    my $first = $value.list[0];
                    my $name  = $first.keys[0];
                    my $body  = $first{$name};

                    %( class-name  => "Arg", 
                       content     => $body )
                }
                when /where_predicates/ {

                    my $first = $value.list[0];
                    my $name  = $first.keys[0];
                    my $body  = $first{$name};

                    %( class-name  => "WherePredicate", 
                       content     => $body )

                }
                when /params/ {

                    my $first = $value.list[0];
                    my $name  = $first<name>;
                    my $body  = $first<kinds>;

                    %(class-name  => "Param", 
                        content   => $body )

                }
                when /bounds/ {

                    my $first = $value.list[0];
                    my $name  = $first.keys[0];
                    my $body  = $first{$name};

                    %( class-name  => "Bound", 
                       content     => $body )
                }
                default {
                    say "parent: $parent";
                    say "value:  $value";
                    die "handle this";
                }
            }

        } else {
            %( class-name  => self.child-class-name(), 
               content     => $value )
        };

        my $obj = Class.new-from-data(
            class-name  => %data<class-name>, 
            content     => %data<content>, 
            inner-class => True, 
            :$!kebab
        );

        self.add-classes($obj);
        self.add-types($obj);
        $obj;
    }

    method add-classes(Mu:D $object) {

        if $object ~~ Class {
            @!classes.push($object);
        }
    }

    method add-types(Mu:D $object ) {

        if $object ~~ Type {
            @!types.push($object);
        }
    }

    method sigil( --> Str ) {
        $!is-array ?? '@' !! '$';
    }

    method raku-name( --> Str ) is rw {

        $!raku-name //= do {

            my $name = $!name;

            if $name !~~ /^<.ident>$/ {
                my $prefix = $!class.split('::')[*-1].lc;
                $name = $prefix ~ $name;
            }

            if $!kebab {
                my $no_underscore = $name.subst(/_/, '-', :g);
                $no_underscore.subst(/<!after ( ^^ || '-' ) >$<up>=<upper>+/, {  "-{ $/<up>.lc }" }, :g).lc
            }
            else {
                $name;
            }
        }
    }

    method has-alternate-name( --> Bool ) {
        self.raku-name ne $!name;
    }

    method child-class-name( --> Str ) is rw {

        $!child-class-name //= do {

            my Str $name = $!name;
            $name ~~ s:g/_(.)/{ $0.uc }/;

            if self.is-array {
                $name ~~ s/s$//;
            }

            $!child-class-name =  $name.tc;
        }
    }

    multi method make-attribute(Int $level = 0 --> Str ) {

        my $indent = "    " x $level;

        my Str $attr-str = $indent ~ "has { self.type-constraint } { self.sigil}.{ self.raku-name }";

        if self.has-alternate-name {
            $attr-str ~= " is json-name('{ self.name }')";

        }
        $attr-str ~ ';';
    }
}

our proto sub infer(|c) { * }

multi sub infer(IO::Path:D :$file!, :$class-name = 'My::JSON', Bool :$kebab = False --> Class ) {
    my $json = $file.slurp();
    infer(:$json, :$class-name, :$kebab);
}

multi sub infer(Str:D :$json!, Str :$class-name = 'My::JSON', Bool :$kebab = False --> Class ) {
    my $content = from-json($json);
    infer(:$content, :$class-name, :$kebab);
}

multi sub infer(Hash:D :$content!, Str :$class-name = 'My::JSON', Bool :$kebab = False --> Class ) {
    my $ret = Class.new-from-data(:$class-name, :$content, :$kebab);
    #$ret.top-level = True;
    $ret;
}
