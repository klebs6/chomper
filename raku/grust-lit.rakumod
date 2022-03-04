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

    method lit($/) {
        make do given ~$/.keys[0] {
            when "lit-str" {
                LitStr.new( val => ~$<lit-str>)
            }
            when "lit-byte" {
                LitByte.new( val => ~$<lit-byte>)
            }
            when "lit-char" {
                LitChar.new( val => ~$<lit-char>)
            }
            when "lit-float" {
                LitFloat.new( val => ~$<lit-float>)
            }
            when "lit-int" {
                LitInteger.new( val => ~$<lit-int>)
            }
            when "kw-true" {
                LitBool.new( val => True)
            }
            when "kw-false" {
                LitBool.new( val => False)
            }
        }
    }
}
