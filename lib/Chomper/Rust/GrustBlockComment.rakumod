unit module Chomper::Rust::GrustBlockComment;

package BlockCommentGrammar is export {

    my enum BlockCommentState <
    blockcomment
    initial
    >;

    my BlockCommentState @block-comment-states;

    our role Rules {

        method push-state($state) {
            @block-comment-states.push: $state;
        }

        method pop-state {
            try @block-comment-states.pop
        }

        method peek-state {
            @block-comment-states[*-1]
        }

        token block-comment-begin {

            \/\* 

            #this is a hack because i havn't debugged
            #"doc-comment" yet and we get these on
            #structs
            \*? 

            { 
                self.push-state(BlockCommentState::<initial>);
                self.push-state(BlockCommentState::<blockcomment>);
            }
        }

        token block-comment-continue {
            || <block-comment-push>
            || <block-comment-pop>
            || <block-comment-inner>
        }

        token block-comment-push {
            <?{self.peek-state().Str eq "blockcomment" }>
            \/\* 

            #see above
            \*?

            { 
                self.push-state(BlockCommentState::<blockcomment>) 
            }
        }

        token block-comment-pop {
            <?{self.peek-state().Str eq "blockcomment" }>
            \*\/
            { 
                self.pop-state();
            }
        }

        token block-comment-inner {
            <?{self.peek-state().Str eq "blockcomment" }>
            [
                || .
                || \n
            ]
        }

        token block-comment-end {
            <?{self.peek-state().Str eq "initial" }>
            {
                self.pop-state();
            }
        }

        token block-comment {
            <block-comment-begin> 
            <block-comment-continue>* 
            <block-comment-end>
        }
    }

    our role Actions {

        method block-comment($/) {
            make $<block-comment-continue>>>.made.join("")
        }

        method block-comment-continue($/) {
            if ~$/.keys[0] eq "block-comment-inner" {
                make ~$/
            } else {
                make ""
            }
        }
    }
}
