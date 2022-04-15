unit module Chomper::Rust::GrustLineComment;

package LineCommentGrammar is export {

    our role Rules {

        token line-comment-begin {
            || \/\/\/
            || \/\/
        }

        token line-comment-body {
            <-[ \r \n ]>* 
        }

        token line-comment {
            <.ws> 
            <.line-comment-begin> 
            <line-comment-body>
        }
    }

    our role Actions {

        method line-comment($/) {
            make $<line-comment-body>.made
        }

        method line-comment-body($/) {
            make ~$/
        }
    }
}
