use Data::Dump::Tree;

use grust-model;
use grust-lit-float;
use grust-lit-int;
use grust-lit-str;

our class LitBool { 
    has $.val; 

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        ddt self;
        exit;
    }
}

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

    method lit-int($/) {
        make LitInteger.new(
            val => ~$/ 
        )
    }

    method lit-float($/) {
        make LitFloat.new(
            val => ~$/ 
        )
    }

    method lit-char($/) {
        make LitChar.new(
            val => ~$/ 
        )
    }

    method lit-byte($/) { 
        make LitByte.new(
            val => ~$/ 
        )
    }

    method lit-str($/) { 
        make LitStr.new(
            val => ~$/ 
        )
    }

    method lit($/) {
        make do given ~$/.keys[0] {
            when "lit-str" {
                $<lit-str>.made
            }
            when "lit-byte" {
                $<lit-byte>.made
            }
            when "lit-char" {
                $<lit-char>.made
            }
            when "lit-float" {
                $<lit-float>.made
            }
            when "lit-int" {
                $<lit-int>.made
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
