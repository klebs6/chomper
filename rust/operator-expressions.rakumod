our role OperatorExpression::Rules {

    proto rule operator-expression { * }

    rule operator-expression:sym<borrow>                { <borrow-expression>                } 
    rule operator-expression:sym<deref>                 { <dereference-expression>           } 
    rule operator-expression:sym<error-propagation>     { <error-propagation-expression>     } 
    rule operator-expression:sym<negation>              { <negation-expression>              } 
    rule operator-expression:sym<arithmetic-or-logical> { <arithmetic-or-logical-expression> } 
    rule operator-expression:sym<comparison>            { <comparison-expression>            } 
    rule operator-expression:sym<lazy-boolean>          { <lazy-boolean-expression>          } 
    rule operator-expression:sym<type-cast>             { <type-cast-expression>             } 
    rule operator-expression:sym<assignment>            { <assignment-expression>            } 
    rule operator-expression:sym<compound-assignment>   { <compound-assignment-expression>   } 
}
