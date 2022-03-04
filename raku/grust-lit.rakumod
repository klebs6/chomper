use grust-model;

#----------------------------------
our role Lit::Rules {

    token lit {  
         || <lit-str> 
         || <lit-byte> 
         || <lit-char> 
         || <lit-float> 
         || <lit-int> 
         || <kw-true> 
         || <kw-false> 
    }
}

our role Lit::Actions {

=begin comment
    method lit:sym<a>($/) {
        make LitByte.new( val => ~$/)
    }

    method lit:sym<b>($/) {
        make LitChar.new( val => ~$/)
    }

    method lit:sym<c>($/) {
        make LitInteger.new( val => ~$/)
    }

    method lit:sym<d>($/) {
        make LitFloat.new( val => ~$/)
    }

    method lit:sym<e>($/) {
        make LitBool.new( val => ~$/)
    }

    method lit:sym<f>($/) {
        make LitBool.new( val => ~$/)
    }

    method lit:sym<g>($/) {
        make $<lit-str>.made
    }
=end comment
}
