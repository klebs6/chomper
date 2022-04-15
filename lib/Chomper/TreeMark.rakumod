
our enum TreeMark<
_Condition 
_Statements 
_Declaration 
_Expression 
_Identifier 
_Type 
_TemplateId
_Literal
_ExprList
>;

our sub sigil(TreeMark $variant) {

    given $variant {
        when TreeMark::<_Condition>   { "C" }
        when TreeMark::<_Statements>  { "S" }
        when TreeMark::<_Declaration> { "D" }
        when TreeMark::<_Expression>  { "E" }
        when TreeMark::<_Identifier>  { "I" }
        when TreeMark::<_Type>        { "T" }
        when TreeMark::<_TemplateId>  { "T<Ts>" }
        when TreeMark::<_Literal>     { "L" }
        when TreeMark::<_ExprList>    { "Es" }
        default {
            die "need handle! " ~ $variant;
        }
    }
}
