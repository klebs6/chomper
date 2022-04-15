unit module Chomper::Rust::GrustUseDeclaration;

use Data::Dump::Tree;

class UseDeclaration is export {
    has $.use-tree;

    has $.text;

    method gist {
        "use " ~ $.use-tree.gist ~ ";"
    }

    method has-name {
        False
    }

    method get-concrete-leafs {
        $.use-tree.get-concrete-leafs().grep: {
            $_ !~~ Nil
        }
    }
}

class UseTreeBasic is export {
    has $.maybe-simple-path;

    has $.text;

    method gist {

        if $.maybe-simple-path {

            $.maybe-simple-path.gist ~ "::" ~ "*"

        } else {

            "*"
        }
    }

    method get-concrete-leafs {
        Nil
    }
}

class UseTreeComplex is export {
    has $.maybe-simple-path;
    has @.use-trees;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-simple-path {
            $builder ~= $.maybe-simple-path.gist ~ "::";
        }

        $builder ~= '{';

        for @.use-trees {
            $builder ~= $_.gist ~ ", ";
        }

        $builder ~ '}'
    }

    method get-concrete-leafs {
        @.use-trees>>.get-concrete-leafs
    }
}

class UseTreeAs is export {
    has $.simple-path;
    has $.as-identifier-or-underscore;

    has $.text;

    method gist {

        my $builder = $.simple-path.gist;

        if $.as-identifier-or-underscore {
            $builder ~= " as " ~ $.as-identifier-or-underscore.gist;
        }

        $builder
    }

    method get-concrete-leafs {
        $.simple-path.get-rightmost-element()
    }
}

package UseDeclarationGrammar is export {

    our role Rules {

        rule use-declaration {
            <kw-use> 
            <use-tree> 
            <tok-semi>
        }

        proto rule use-tree { * }

        rule use-tree:sym<basic> {
            [
                <simple-path>? 
                <tok-path-sep>
            ]? 
            <tok-star>
        }

        rule use-tree:sym<complex> {
           [ <simple-path>? <tok-path-sep> ]? 
           <tok-lbrace>
           [
               <use-tree>+ %% <tok-comma>
           ]? 
           <tok-rbrace>
        }

        rule use-tree:sym<as> {
            <simple-path>
           [ 
               <kw-as> 
               <identifier-or-underscore>
           ]?
        }
    }

    our role Actions {

        method use-declaration($/) {
            make UseDeclaration.new(
                use-tree => $<use-tree>.made,
                text     => $/.Str,
            )
        }

        method use-tree:sym<basic>($/) {
            make UseTreeBasic.new(
                maybe-simple-path => $<simple-path>.made,
                text              => $/.Str,
            )
        }

        method use-tree:sym<complex>($/) {
            make UseTreeComplex.new(
                maybe-simple-path => $<simple-path>.made,
                use-trees         => $<use-tree>>>.made,
                text              => $/.Str,
            )
        }

        method use-tree:sym<as>($/) {
            make UseTreeAs.new(
                simple-path                 => $<simple-path>.made,
                as-identifier-or-underscore => $<identifier-or-underscore>.made,
                text                        => $/.Str,
            )
        }
    }
}
