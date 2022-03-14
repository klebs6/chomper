our class UseDeclaration {
    has $.use-tree;

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

our class UseTreeBasic {
    has $.maybe-simple-path;

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

our class UseTreeComplex {
    has $.maybe-simple-path;
    has @.use-trees;

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

our class UseTreeAs {
    has $.simple-path;
    has $.as-identified-or-underscore;

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

our role UseDeclaration::Rules {

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

our role UseDeclaration::Actions {}
