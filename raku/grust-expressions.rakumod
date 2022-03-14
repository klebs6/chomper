
our class BaseExpression {
    has @.outer-attributes;
    has $.expression-item;

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

our class MethodCallExpressionSuffix {
    has $.path-expr-segment;
    has @.maybe-call-params;

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

our class IndexExpressionSuffix {
    has $.expression;

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

our class FieldExpressionSuffix {
    has $.identifier;

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

our class CallExpressionSuffix {
    has @.maybe-call-params;

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

our class AwaitExpressionSuffix { 

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

our class TupleIndexExpressionSuffix {
    has $.tuple-index;

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

our class ErrorPropagationExpressionSuffix { 

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

our class SuffixedExpression {
    has $.base-expression;
    has @.suffixed-expression-suffix;

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

our class UnaryPrefixBang  { 

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

our class UnaryPrefixMinus { 

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

our class UnaryPrefixStar  { 

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

our class UnaryExpression {
    has @.unary-prefixes;
    has $.suffixed-expression;

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

our class BorrowExpressionPrefix {
    has Int $.borrow-count;
    has Bool $.mutable;

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

our class BorrowExpression {
    has @.borrow-expression-prefixes;
    has $.unary-expression;

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

our class CastExpression {
    has $.borrow-expression;
    has @.cast-targets;

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

our class CastTarget {
    has $.type-no-bounds;

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

our class ModuloExpression {
    has @.cast-expressions;

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

our class DivisionExpression {
    has @.modulo-expressions;

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

our class MultiplicativeExpression {
    has @.division-expressions;

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

our class SubtractiveExpression {
    has @.multiplicative-expressions;

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

our class AdditiveExpression {
    has @.subtractive-expressions;

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

our class BinaryShrExpression {
    has @.additive-expressions;

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

our class BinaryShlExpression {
    has @.binary-shr-expressions;

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

our class BinaryAndExpression {
    has @.binary-shl-expressions;

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

our class BinaryXorExpression {
    has @.binary-and-expressions;

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

our class BinaryOrExpression {
    has @.binary-xor-expressions;

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

our class BinaryLeExpression {
    has @.binary-or-expressions;

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

our class BinaryGeExpression {
    has @.binary-le-expressions;

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

our class BinaryLtExpression {
    has @.binary-ge-expressions;

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

our class BinaryGtExpression {
    has @.binary-lt-expressions;

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

our class BinaryNeExpression {
    has @.binary-gt-expressions;

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

our class BinaryEqEqExpression {
    has @.binary-ne-expression;

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

our class BinaryAndAndExpression {
    has @.binary-eqeq-expressions;

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

our class BinaryOrOrExpression {
    has @.binary-andand-expressions;

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

our class RangeExpressionFullEq {
    has @.binary-oror-expressions;

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

our class RangeExpressionFull {
    has @.binary-oror-expressions;

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

our class RangeExpressionTo {
    has $.binary-oror-expression;

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

our class RangeExpressionToEq {
    has $.binary-oror-expression;

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

our class RangeExpressionFrom {
    has $.binary-oror-expression;

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

our class RangeExpressionOpen {


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

our class ShreqExpression {
    has @.range-expressions;

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

our class ShleqExpression {
    has @.shreq-expressions;

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

our class XoreqExpression {
    has @.shleq-expressions;

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

our class OreqExpression {
    has @.xoreq-expressions;

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

our class AndeqExpression {
    has @.oreq-expressions;

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

our class ModeqExpression {
    has @.andeq-expressions;

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

our class SlasheqExpression {
    has @.modeq-expressions;

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

our class StareqExpression {
    has @.slasheq-expressions;

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

our class MinuseqExpression {
    has @.stareq-expressions;

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

our class AddeqExpression {
    has @.minuseq-expressions;

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

our class AssignExpression {
    has @.addeq-expressions;

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

our class Expression {
    has $.assign-expression;

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

our class GroupedExpression {
    has $.expression;

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

our $NOSTRUCT = False;
our $NOBLOCK  = False;

our role Expression::Rules {

    rule expression-nostruct { 
        {$NOSTRUCT = True}
        <expression>
        {$NOSTRUCT = False}
    }

    rule expression-noblock { 
        {$NOBLOCK = True}
        <expression>
        {$NOBLOCK = False}
    }

    rule base-expression {
        <outer-attribute>* 
        <expression-item> 
        {
            #once we parse one base-expression,
            #reset noblock and nostruct
            $NOBLOCK  = False;
            $NOSTRUCT = False;
        }
    }

    proto rule suffixed-expression-suffix { * }

    rule suffixed-expression-suffix:sym<method-call> {
        <tok-dot> 
        <path-expr-segment> 
        <tok-lparen> 
        <call-params>? 
        <tok-rparen> 
    }

    rule suffixed-expression-suffix:sym<index> {
        <tok-lbrack> 
        <expression> 
        <tok-rbrack>  
    }

    rule suffixed-expression-suffix:sym<field> {

        <tok-dot> 

        #making this <expression> results in
        #massive performance loss
        <identifier>  
    }

    rule call-params {
        <expression>+ %% <tok-comma>
    }

    rule suffixed-expression-suffix:sym<call> {
        <tok-lparen> 
        <call-params>?
        <tok-rparen>
    }

    rule suffixed-expression-suffix:sym<await> {
        <tok-dot> <kw-await>
    }

    rule suffixed-expression-suffix:sym<tuple-index> {
        <tok-dot> <tuple-index>
    }

    rule suffixed-expression-suffix:sym<error-propagation> {
        <tok-qmark>
    }

    rule suffixed-expression {
        <base-expression>
        <suffixed-expression-suffix>*
    }

    #--------------------

    proto rule unary-prefix { * }

    rule unary-prefix:sym<bang> {
        <tok-bang>
    }

    rule unary-prefix:sym<minus> {
        <tok-minus>
    }

    rule unary-prefix:sym<star> {
        <tok-star>
    }

    rule unary-expression {
        <unary-prefix>*
        <suffixed-expression>
    }

    rule borrow-expression {
        [
            <tok-and> 
            <tok-and>?
            <kw-mut>? 
        ]*
        <unary-expression>
    }

    rule cast-expression {
        <borrow-expression>
        [ <kw-as> <type-no-bounds> ]*
    }

    #--------------------
    rule modulo-expression {
        <cast-expression>+ %% <tok-percent>
    }

    rule division-expression {
        <modulo-expression>+ %% <tok-slash>
    }

    rule multiplicative-expression {
        <division-expression>+ %% <tok-star>
    }

    rule subtractive-expression {
        <multiplicative-expression>+ %% <tok-minus>
    }

    rule additive-expression {
        <subtractive-expression>+ %% <tok-plus>
    }

    rule binary-shr-expression {
        <additive-expression>+ %% <tok-shr>
    }

    rule binary-shl-expression {
        <binary-shr-expression>+ %% <tok-shl>
    }

    #--------------------
    rule binary-and-expression {
        <binary-shl-expression>+ %% <tok-and>
    }

    rule binary-xor-expression {
        <binary-and-expression>+ %% <tok-caret>
    }

    rule binary-or-expression {
        <binary-xor-expression>+ %% <tok-or>
    }

    #--------------------
    rule binary-le-expression {
        <binary-or-expression>+ %% <tok-le>
    }

    rule binary-ge-expression {
        <binary-le-expression>+ %% <tok-ge>
    }

    rule binary-lt-expression {
        <binary-ge-expression>+ %% <tok-lt>
    }

    rule binary-gt-expression {
        <binary-lt-expression>+ %% <tok-gt>
    }

    rule binary-ne-expression {
        <binary-gt-expression>+ %% <tok-ne>
    }

    rule binary-eqeq-expression {
        <binary-ne-expression>+ %% <tok-eqeq>
    }

    rule binary-andand-expression {
        <binary-eqeq-expression>+ %% <tok-andand>
    }

    rule binary-oror-expression {
        <binary-andand-expression>+ %% <tok-oror>
    }

    #--------------------
    proto rule range-expression { * }

    rule range-expression:sym<full-eq> { <binary-oror-expression> [<tok-dotdoteq>  <binary-oror-expression>]+ }

    rule range-expression:sym<full> {  
        <binary-oror-expression> [<tok-dotdot>  <binary-oror-expression>]+
    }

    rule range-expression:sym<to> {  
        <tok-dotdot> 
        <binary-oror-expression>
    }

    rule range-expression:sym<to-eq> {  
        <tok-dotdoteq> 
        <binary-oror-expression>
    }

    rule range-expression:sym<from> {  
        <binary-oror-expression>
        <tok-dotdot> 
    }

    rule range-expression:sym<open> {  <tok-dotdot> }

    rule range-expression:sym<base> {  <binary-oror-expression> }

    #--------------------

    rule shreq-expression {
        <range-expression>+ %% <tok-shreq>
    }

    rule shleq-expression {
        <shreq-expression>+ %% <tok-shleq>
    }

    rule xoreq-expression {
        <shleq-expression>+ %% <tok-careteq>
    }

    rule oreq-expression {
        <xoreq-expression>+ %% <tok-oreq>
    }

    rule andeq-expression {
        <oreq-expression>+ %% <tok-andeq>
    }

    rule modeq-expression {
        <andeq-expression>+ %% <tok-percenteq>
    }

    rule slasheq-expression {
        <modeq-expression>+ %% <tok-slasheq>
    }

    rule stareq-expression {
        <slasheq-expression>+ %% <tok-stareq>
    }

    rule minuseq-expression {
        <stareq-expression>+ %% <tok-minuseq>
    }

    rule addeq-expression {
        <minuseq-expression>+ %% <tok-pluseq>
    }

    rule assign-expression {
        <addeq-expression>+ %% <tok-eq>
    }

    rule expression {
        <assign-expression>
    }

    #-------------------------
    proto rule expression-item { * }

    rule expression-item:sym<block>    { 
        #<?{$NOBLOCK eq False}> 
        <expression-with-block> 
    }
    rule expression-item:sym<macro>    { <macro-expression> } 

    rule expression-item:sym<struct>   { 
        #<?{$NOSTRUCT eq False}>  #why does <?{True}> break matching here?
        <struct-expression> 
    }

    rule expression-item:sym<literal>  { <literal-expression> } 
    rule expression-item:sym<path>     { <path-expression>    }
    rule expression-item:sym<grouped>  { <tok-lparen> <expression> <tok-rparen> }
    rule expression-item:sym<array>    { <array-expression>   }
    rule expression-item:sym<tuple>    { <tuple-expression>   }
    rule expression-item:sym<closure>  { <closure-expression> } 
    rule expression-item:sym<continue> { <continue-expression> } 
    rule expression-item:sym<break>    { <break-expression> } 
    rule expression-item:sym<return>   { <return-expression> } 

    #-------------------------
    proto rule expression-with-block { * }
    rule expression-with-block:sym<block>        { <block-expression> }
    rule expression-with-block:sym<match>        { <match-expression> }
    rule expression-with-block:sym<async-block>  { <async-block-expression> }
    rule expression-with-block:sym<unsafe-block> { <unsafe-block-expression> }
    rule expression-with-block:sym<loop>         { <loop-expression> }
    rule expression-with-block:sym<if>           { <if-expression> }
    rule expression-with-block:sym<if-let>       { <if-let-expression> }
    rule expression-with-block:sym<comment>      { <comment> }
}

our role Expression::Actions {}
