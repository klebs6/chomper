our class TyClosure {
    has $.anon-params;
    has $.ret-ty;
    has $.maybe-bounds;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our role TyClosure::Rules {

    proto rule ty-closure { * }

    rule ty-closure:sym<a> {
        <kw-unsafe> 
        '|' <anon-params> '|' 
        <maybe-bounds> 
        <ret-ty>
    }

    rule ty-closure:sym<b> {
        '|' <anon-params> '|' 
        <maybe-bounds> 
        <ret-ty>
    }

    rule ty-closure:sym<c> {
        <kw-unsafe> 
        <tok-oror> 
        <maybe-bounds> 
        <ret-ty>
    }

    rule ty-closure:sym<d> {
        <tok-oror> 
        <maybe-bounds> 
        <ret-ty>
    }
}

our role TyClosure::Actions {

    method ty-closure:sym<a>($/) {
        make TyClosure.new(
            anon-params  =>  $<anon-params>.made,
            maybe-bounds =>  $<maybe-bounds>.made,
            ret-ty       =>  $<ret-ty>.made,
            text         => ~$/,
        )
    }

    method ty-closure:sym<b>($/) {
        make TyClosure.new(
            anon-params  =>  $<anon-params>.made,
            maybe-bounds =>  $<maybe-bounds>.made,
            ret-ty       =>  $<ret-ty>.made,
            text         => ~$/,
        )
    }

    method ty-closure:sym<c>($/) {
        make TyClosure.new(
            maybe-bounds =>  $<maybe-bounds>.made,
            ret-ty       =>  $<ret-ty>.made,
            text         => ~$/,
        )
    }

    method ty-closure:sym<d>($/) {
        make TyClosure.new(
            maybe-bounds =>  $<maybe-bounds>.made,
            ret-ty       =>  $<ret-ty>.made,
            text         => ~$/,
        )
    }
}
