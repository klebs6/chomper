unit module Chomper::Rust::GrustWeakKeywords;

use Data::Dump::Tree;

package WeakKeywordsGrammar is export {

    #`( These keywords have special meaning only in
    certain contexts. For example, it is possible to
    declare a variable or method with the name union.)
    our role Rules {
        token kw-union          { union }
        token kw-staticlifetime { \'static }

        proto token weak-keyword { * }
        token weak-keyword:sym<union> { <kw-union> }
        token weak-keyword:sym<staticlt> { <kw-staticlifetime> }
    }

    our role Actions {}
}
