our role DereferenceExpression::Rules {

    rule dereference-expression { 
        <tok-star> 
        <expression> 
    }
}

our role DereferenceExpression::Actions {}
