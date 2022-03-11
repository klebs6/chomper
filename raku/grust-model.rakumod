our class BlockExpression {
    has @.inner-attributes;
    has @.statements;
}

our class AsyncBlockExpression {
    has Bool $.mode;
    has $.block-expression;
}

our class UnsafeBlockExpression {
    has $.block-expression;
}

our class ArrayExpression {
    has $.maybe-array-elements;
}

our class ArrayElementsItemQuantity {

}

our class ArrayElementsList {
    has @.expressions;
}
