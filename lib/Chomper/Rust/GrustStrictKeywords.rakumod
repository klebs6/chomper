unit module Chomper::Rust::GrustStrictKeywords;

use Data::Dump::Tree;

#`(
These keywords can only be used in their correct
contexts. They cannot be used as the names of:

-Items
-Variables and function parameters
-Fields and variants
-Type parameters
-Lifetime parameters or loop labels
-Macros or attributes
-Macro placeholders
-Crates
)
our role StrictKeywords::Rules {
    token kw-as        { as }
    token kw-break     { break }
    token kw-const     { const }
    token kw-continue  { continue }
    token kw-crate     { crate }
    token kw-default   { default } 
    token kw-else      { else }
    token kw-enum      { enum }
    token kw-extern    { extern }
    token kw-false     { false }
    token kw-fn        { fn }
    token kw-for       { for }
    token kw-if        { if }
    token kw-impl      { impl }
    token kw-in        { in }
    token kw-let       { let }
    token kw-loop      { loop }
    token kw-match     { match }
    token kw-mod       { mod }
    token kw-move      { move }
    token kw-mut       { mut }
    token kw-pub       { pub }
    token kw-ref       { ref }
    token kw-return    { return }
    token kw-selfvalue { self }
    token kw-selftype  { Self <!before \w> }
    token kw-static    { static }
    token kw-struct    { struct }
    token kw-super     { super }
    token kw-trait     { trait }
    token kw-true      { true }
    token kw-type      { type }
    token kw-unsafe    { unsafe }
    token kw-use       { use }
    token kw-where     { where }
    token kw-while     { while }

    #added in the 2018 edition
    token kw-async     { async }
    token kw-await     { await }
    token kw-dyn       { dyn }

    proto token strict-keyword { * }
    token strict-keyword:sym<kw-as>        { <kw-as>        }
    token strict-keyword:sym<kw-break>     { <kw-break>     }
    token strict-keyword:sym<kw-const>     { <kw-const>     }
    token strict-keyword:sym<kw-continue>  { <kw-continue>  }
    token strict-keyword:sym<kw-crate>     { <kw-crate>     }
    token strict-keyword:sym<kw-else>      { <kw-else>      }
    token strict-keyword:sym<kw-enum>      { <kw-enum>      }
    token strict-keyword:sym<kw-extern>    { <kw-extern>    }
    token strict-keyword:sym<kw-false>     { <kw-false>     }
    token strict-keyword:sym<kw-fn>        { <kw-fn>        }
    token strict-keyword:sym<kw-for>       { <kw-for>       }
    token strict-keyword:sym<kw-if>        { <kw-if>        }
    token strict-keyword:sym<kw-impl>      { <kw-impl>      }
    token strict-keyword:sym<kw-in>        { <kw-in>        }
    token strict-keyword:sym<kw-let>       { <kw-let>       }
    token strict-keyword:sym<kw-loop>      { <kw-loop>      }
    token strict-keyword:sym<kw-match>     { <kw-match>     }
    token strict-keyword:sym<kw-mod>       { <kw-mod>       }
    token strict-keyword:sym<kw-move>      { <kw-move>      }
    token strict-keyword:sym<kw-mut>       { <kw-mut>       }
    token strict-keyword:sym<kw-pub>       { <kw-pub>       }
    token strict-keyword:sym<kw-ref>       { <kw-ref>       }
    token strict-keyword:sym<kw-return>    { <kw-return>    }
    token strict-keyword:sym<kw-selfvalue> { <kw-selfvalue> }
    token strict-keyword:sym<kw-selftype>  { <kw-selftype>  }
    token strict-keyword:sym<kw-static>    { <kw-static>    }
    token strict-keyword:sym<kw-struct>    { <kw-struct>    }
    token strict-keyword:sym<kw-super>     { <kw-super>     }
    token strict-keyword:sym<kw-trait>     { <kw-trait>     }
    token strict-keyword:sym<kw-true>      { <kw-true>      }
    token strict-keyword:sym<kw-type>      { <kw-type>      }
    token strict-keyword:sym<kw-unsafe>    { <kw-unsafe>    }
    token strict-keyword:sym<kw-use>       { <kw-use>       }
    token strict-keyword:sym<kw-where>     { <kw-where>     }
    token strict-keyword:sym<kw-while>     { <kw-while>     }
    token strict-keyword:sym<kw-async>     { <kw-async>     }
    token strict-keyword:sym<kw-await>     { <kw-await>     }
    token strict-keyword:sym<kw-dyn>       { <kw-dyn>       }
}

our role StrictKeywords::Actions {}