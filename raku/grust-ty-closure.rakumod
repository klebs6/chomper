our class TyClosure {
    has $.anon-params;
    has $.ret-ty;
    has $.maybe-bounds;
}

our class TyClosure::Rules {

    proto rule ty-closure { * }

    rule ty-closure:sym<a> {
        <UNSAFE> 
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
        <UNSAFE> 
        <OROR> 
        <maybe-bounds> 
        <ret-ty>
    }

    rule ty-closure:sym<d> {
        <OROR> 
        <maybe-bounds> 
        <ret-ty>
    }
}

our class TyClosure::Actions {

    method ty-closure:sym<a>($/) {
        make TyClosure.new(
            anon-params  =>  $<anon-params>.made,
            maybe-bounds =>  $<maybe-bounds>.made,
            ret-ty       =>  $<ret-ty>.made,
        )
    }

    method ty-closure:sym<b>($/) {
        make TyClosure.new(
            anon-params  =>  $<anon-params>.made,
            maybe-bounds =>  $<maybe-bounds>.made,
            ret-ty       =>  $<ret-ty>.made,
        )
    }

    method ty-closure:sym<c>($/) {
        make TyClosure.new(
            maybe-bounds =>  $<maybe-bounds>.made,
            ret-ty       =>  $<ret-ty>.made,
        )
    }

    method ty-closure:sym<d>($/) {
        make TyClosure.new(
            maybe-bounds =>  $<maybe-bounds>.made,
            ret-ty       =>  $<ret-ty>.made,
        )
    }
}

