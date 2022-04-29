unit module Chomper::Rust::GrustExpressions;

use Data::Dump::Tree;

our class CommentedExpression is export {
    has $.comment;
    has $.expression;
}

our class BaseExpression is export {
    has @.outer-attributes;
    has $.expression-item;

    has $.text;

    method gist {
        qq:to/END/.chomp.trim
        {@.outer-attributes>>.gist.join("\n")}
        {$.expression-item.gist}
        END
    }
}

our class MethodCallExpressionSuffix is export {
    has $.path-expr-segment;
    has $.maybe-call-params;

    has $.text;

    method gist {

        if $.maybe-call-params {

            "." 
            ~ $.path-expr-segment.gist 
            ~ "(" 
            ~ $.maybe-call-params.List>>.gist.join(",") 
            ~ ")"

        } else {

            "." 
            ~ $.path-expr-segment.gist 
            ~ "()" 

        }
    }
}

our class IndexExpressionSuffix is export {
    has $.expression;

    has $.text;

    method gist {
        "[" ~ $.expression.gist ~ "]"
    }
}

our class FieldExpressionSuffix is export {
    has $.identifier;

    method gist {
        "." ~ $.identifier.gist.chomp
    }
}

our class CallExpressionSuffix is export {
    has $.maybe-call-params;

    has $.text;

    method gist {

        if $.maybe-call-params {

            "(" 
            ~ $.maybe-call-params.List>>.gist.join(",") 
            ~ ")"

        } else {

            "()" 
        }
    }
}

our class AwaitExpressionSuffix is export { 

    has $.text;

    method gist {
        ".await"
    }
}

our class TupleIndexExpressionSuffix is export {
    has $.tuple-index;

    has $.text;

    method gist {
        "." ~ $.tuple-index.gist
    }
}

our class ErrorPropagationExpressionSuffix is export {

    has $.text;

    method gist {
        "?"
    }
}

our class SuffixedExpression is export {
    has $.base-expression;
    has @.suffixed-expression-suffix;

    has $.text;

    method gist {
        [
            $.base-expression.gist.chomp.trim, 
            |@.suffixed-expression-suffix>>.gist.join("")
        ].join("").chomp
    }
}

our class UnaryPrefixBang is export { 

    has $.text;

    method gist {
        "!"
    }
}

our class UnaryPrefixMinus is export {

    has $.text;

    method gist {
        "-"
    }
}

class UnaryPrefixStar is export { 

    has $.text;

    method gist {
        "*"
    }
}

class UnaryExpression is export {
    has @.unary-prefixes;
    has $.suffixed-expression;

    has $.text;

    method gist {
        @.unary-prefixes>>.gist.join("") ~ $.suffixed-expression.gist
    }
}

class BorrowExpressionPrefix is export {
    has Int $.borrow-count;
    has Bool $.mutable;

    has $.text;

    method gist {

        my $builder = "";

        for $.borrow-count {
            $builder ~= "&";
        }

        if $.mutable {
            $builder ~= "mut ";
        }

        $builder
    }
}

class BorrowExpression is export {
    has @.borrow-expression-prefixes;
    has $.unary-expression;

    has $.text;

    method gist {

        my $builder = "";

        for @.borrow-expression-prefixes {
            $builder ~= $_.gist;
        }

        $builder ~ $.unary-expression.gist;
    }
}

class CastExpression is export {
    has $.borrow-expression;
    has @.cast-targets;

    has $.text;

    method gist {

        my $builder = $.borrow-expression.gist;

        for @.cast-targets {
            $builder ~= " as " ~ $_.gist;
        }

        $builder
    }
}

#-----------------------------------
package MultiplicativeOperator is export {

    # token multiplicative-operator:sym<*> { <star> }
    our class Star {

        has $.text;

        method name {
            'MultiplicativeOperator::Star'
        }

        method gist(:$treemark=False) {
            "*"
        }
    }

    # token multiplicative-operator:sym</> { <div_> }
    our class Slash {

        has $.text;

        method name {
            'MultiplicativeOperator::Slash'
        }

        method gist(:$treemark=False) {
            "/"
        }
    }

    # token multiplicative-operator:sym<%> { <mod_> }
    our class Mod {

        has $.text;

        method name {
            'MultiplicativeOperator::Mod'
        }

        method gist(:$treemark=False) {
            "%"
        }
    }
}

# rule multiplicative-expression { 
#   <cast-expression> 
#   <multiplicative-expression-tail>* 
# }
class MultiplicativeExpression is export {
    has $.cast-expression is required;
    has @.multiplicative-expression-tail is required;

    has $.text;

    method name {
        'MultiplicativeExpression'
    }

    method gist(:$treemark=False) {
        my $b = $.cast-expression;
        my @t = @.multiplicative-expression-tail;

        my $buffer = $b.gist(:$treemark);

        for @t {
            $buffer ~= " " ~ $_.gist(:$treemark);
        }

        $buffer
    }
}

# rule multiplicative-expression-tail { 
#   <multiplicative-operator> 
#   <cast-expression> 
# }
class MultiplicativeExpressionTail is export {

    has $.multiplicative-operator is required;
    has $.cast-expression         is required;

    has $.text;

    method name {
        'MultiplicativeExpressionTail'
    }

    method gist(:$treemark=False) {
        $.multiplicative-operator.gist(:$treemark) 
        ~ " " 
        ~ $.cast-expression.gist(:$treemark)
    }
}

#------------------------------------------
package AdditiveOperator is export {

    # token additive-operator:sym<plus> { <plus> }
    our class Plus {

        has $.text;

        method name {
            'AdditiveOperator::Plus'
        }

        method gist(:$treemark=False) {
            "+"
        }
    }

    # token additive-operator:sym<minus> { <minus> }
    our class Minus {

        has $.text;

        method name {
            'AdditiveOperator::Minus'
        }

        method gist(:$treemark=False) {
            "-"
        }
    }
}

# rule additive-expression-tail { 
#   <additive-operator> 
#   <multiplicative-expression> 
# }
class AdditiveExpressionTail is export {
    has $.additive-operator         is required;
    has $.multiplicative-expression is required;

    method name {
        'AdditiveExpressionTail'
    }

    method gist(:$treemark=False) {
        $.additive-operator.gist(:$treemark) ~ " " ~ $.multiplicative-expression.gist(:$treemark)
    }
}

# rule additive-expression { 
#   <multiplicative-expression> 
#   <additive-expression-tail>* 
# }
class AdditiveExpression is export {

    has $.multiplicative-expression is required;
    has @.additive-expression-tail;

    method name {
        'AdditiveExpression'
    }

    method gist(:$treemark=False) {
        $.multiplicative-expression.gist(:$treemark) 
        ~ " " 
        ~ @.additive-expression-tail>>.gist(:$treemark).join(" ")
    }
}

#----------------------------------
# rule binary-shift-expression-tail { 
#   <binary-shift-operator> 
#   <additive-expression> 
# }
class BinaryShiftExpressionTail is export {
    has $.binary-shift-operator is required;
    has $.additive-expression   is required;

    has $.text;

    method name {
        'BinaryShiftExpressionTail'
    }

    method gist(:$treemark=False) {
        $.binary-shift-operator.gist(:$treemark) 
        ~ " " 
        ~ $.additive-expression.gist(:$treemark)
    }
}

# rule binary-shift-expression { 
#   <additive-expression> 
#   <binary-shift-expression-tail>* 
# }
class BinaryShiftExpression is export {
    has $.additive-expression is required;
    has @.binary-shift-expression-tail is required;

    has $.text;

    method name {
        'BinaryShiftExpression'
    }

    method gist(:$treemark=False) {
        $.additive-expression.gist(:$treemark) 
        ~ " " 
        ~ @.binary-shift-expression-tail>>.gist(:$treemark).join(" ")
    }
}

package BinaryShiftOperator is export {

    # rule binary-shift-operator:sym<right> { <.greater> <.greater> }
    class Right {

        has $.text;

        method name {
            'BinaryShiftOperator::Right'
        }

        method gist(:$treemark=False) {
            ">>"
        }
    }

    # rule binary-shift-operator:sym<left> { <.less> <.less> }
    class Left {

        has $.text;

        method name {
            'BinaryShiftOperator::Left'
        }

        method gist(:$treemark=False) {
            "<<"
        }
    }
}

#----------------------------
class BinaryAndExpression is export {
    has @.binary-shift-expressions;

    has $.text;

    method gist {
        @.binary-shift-expressions>>.gist.join(" & ")
    }
}

class BinaryXorExpression is export {
    has @.binary-and-expressions;

    has $.text;

    method gist {
        @.binary-and-expressions>>.gist.join(" ^ ")
    }
}

class BinaryOrExpression is export {
    has @.binary-xor-expressions;

    has $.text;

    method gist {
        @.binary-xor-expressions>>.gist.join(" | ")
    }
}

class BinaryLeExpression is export {
    has @.binary-or-expressions;

    has $.text;

    method gist {
        @.binary-or-expressions>>.gist.join(" <= ")
    }
}

class BinaryGeExpression is export {
    has @.binary-le-expressions;

    has $.text;

    method gist {
        @.binary-le-expressions>>.gist.join(" >= ")
    }
}

class BinaryLtExpression is export {
    has @.binary-ge-expressions;

    has $.text;

    method gist {
        @.binary-ge-expressions>>.gist.join(" < ")
    }
}

class BinaryGtExpression is export {
    has @.binary-lt-expressions;

    has $.text;

    method gist {
        @.binary-lt-expressions>>.gist.join(" > ")
    }
}

class BinaryNeExpression is export {
    has @.binary-gt-expressions;

    has $.text;

    method gist {
        @.binary-gt-expressions>>.gist.join(" != ")
    }
}

class BinaryEqEqExpression is export {
    has @.binary-ne-expressions;

    has $.text;

    method gist {
        @.binary-ne-expressions>>.gist.join(" == ")
    }
}

class BinaryAndAndExpression is export {
    has @.binary-eqeq-expressions;

    has $.text;

    method gist {
        @.binary-eqeq-expressions>>.gist.join(" && ") 
    }
}

class BinaryOrOrExpression is export {
    has @.binary-andand-expressions;

    has $.text;

    method gist {
        @.binary-andand-expressions>>.gist.join(" || ") 
    }
}

class RangeExpressionFullEq is export {
    has @.binary-oror-expressions;

    has $.text;

    method gist {
        @.binary-oror-expressions[0].gist 
        ~ "..="
        ~ @.binary-oror-expressions[1].gist 
    }
}

class RangeExpressionFull is export {
    has @.binary-oror-expressions;

    has $.text;

    method gist {
        @.binary-oror-expressions[0].gist 
        ~ ".."
        ~ @.binary-oror-expressions[1].gist 
    }
}

class RangeExpressionTo is export {
    has $.binary-oror-expression;

    has $.text;

    method gist {
        ".."
        ~ $.binary-oror-expression.gist 
    }
}

class RangeExpressionToEq is export {

    has $.binary-oror-expression;

    has $.text;

    method gist {
        "..="
        ~ $.binary-oror-expression.gist 
    }
}

class RangeExpressionFrom is export {
    has $.binary-oror-expression;

    has $.text;

    method gist {
        $.binary-oror-expression.gist ~ ".."
    }
}

class RangeExpressionOpen is export {

    has $.text;

    method gist {
        ".."
    }
}

class ShrEqExpression is export {
    has @.range-expressions;

    has $.text;

    method gist {
        @.range-expressions>>.gist>>.chomp.join(" >>= ")
    }
}

class ShlEqExpression is export {
    has @.shreq-expressions;

    has $.text;

    method gist {
        @.shreq-expressions>>.gist>>.chomp.join(" <<= ")
    }
}

class XorEqExpression is export {
    has @.shleq-expressions;

    has $.text;

    method gist {
        @.shleq-expressions>>.gist>>.chomp.join(" ^= ")
    }
}

class OrEqExpression is export {
    has @.xoreq-expressions;

    has $.text;

    method gist {
        @.xoreq-expressions>>.gist>>.chomp.join(" |= ")
    }
}

class AndEqExpression is export {
    has @.oreq-expressions;

    has $.text;

    method gist {
        @.oreq-expressions>>.gist>>.chomp.join(" &= ")
    }
}

class ModEqExpression is export {
    has @.andeq-expressions;

    has $.text;

    method gist {
        @.andeq-expressions>>.gist>>.chomp.join(" %= ")
    }
}

class SlashEqExpression is export {
    has @.modeq-expressions;

    has $.text;

    method gist {
        @.modeq-expressions>>.gist>>.chomp.join(" /= ")
    }
}

class StarEqExpression is export {
    has @.slasheq-expressions;

    has $.text;

    method gist {
        @.slasheq-expressions>>.gist>>.chomp.join(" *= ")
    }
}

class MinusEqExpression is export {
    has @.stareq-expressions;

    has $.text;

    method gist {
        @.stareq-expressions>>.gist>>.chomp.join(" -= ")
    }
}

class AddEqExpression is export {
    has @.minuseq-expressions;

    has $.text;

    method gist {
        @.minuseq-expressions>>.gist>>.chomp.join(" += ")
    }
}

class AssignExpression is export {
    has @.addeq-expressions;

    has $.text;

    method gist {
        @.addeq-expressions>>.gist>>.chomp.join(" = ")
    }
}

class Expression is export {
    has $.assign-expression;

    has $.text;

    method gist {
        $.assign-expression.gist
    }
}

class GroupedExpression is export {
    has $.expression;

    has $.text;

    method gist {
        "(" ~ $.expression.gist ~ ")"
    }
}

our $NOSTRUCT is export = False;
our $NOBLOCK  is export = False;

package ExpressionGrammar is export {

    our role Rules {

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

        rule borrow-expression-prefix {
            <tok-and> 
            <tok-and>?
            <kw-mut>? 
        }

        rule borrow-expression {
            <borrow-expression-prefix>*
            <unary-expression>
        }

        rule cast-expression {
            <borrow-expression>
            [ <kw-as> <type-no-bounds> ]*
        }

        #--------------------
        proto token multiplicative-operator { * }
        token multiplicative-operator:sym<*> { <tok-star> }
        token multiplicative-operator:sym</> { <tok-slash> }
        token multiplicative-operator:sym<%> { <tok-percent> }

        rule multiplicative-expression {
            <cast-expression>
            <multiplicative-expression-tail>*
        }

        rule multiplicative-expression-tail {
            <multiplicative-operator> 
            <cast-expression>
        }

        #------------------------
        proto token additive-operator { * }
        token additive-operator:sym<plus>  {  <tok-plus> }
        token additive-operator:sym<minus> {  <tok-minus> }

        rule additive-expression-tail {
            <additive-operator> 
            <multiplicative-expression>
        }

        rule additive-expression {
            <multiplicative-expression>
            <additive-expression-tail>*
        }

        #-----------------
        rule binary-shift-expression-tail {
            <binary-shift-operator>
            <additive-expression>
        }

        rule binary-shift-expression {
            <additive-expression>
            <binary-shift-expression-tail>*
        }

        proto rule binary-shift-operator { * }
        rule binary-shift-operator:sym<right> { <tok-shr> }
        rule binary-shift-operator:sym<left>  { <tok-shl> }

        #--------------------
        rule binary-and-expression {
            <binary-shift-expression>+ %% <tok-and>
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

        rule maybe-commented-expression {
            <comment>?
            <expression>
        }

        #-------------------------
        proto rule expression-item { * }

        rule expression-item:sym<block>    { 
            #<?{$NOBLOCK eq False}> 
            <expression-with-block> 
        }

        rule expression-item:sym<macro>    { <macro-expression> } 

        #NOTE: moved path and literal expressions
        #above struct... does this break something?
        rule expression-item:sym<literal>  { <literal-expression> } 
        rule expression-item:sym<path>     { <path-expression>    }

        rule expression-item:sym<struct>   { 
            #<?{$NOSTRUCT eq False}>  #why does <?{True}> break matching here?
            <struct-expression> 
        }

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

    our role Actions {

        method expression-nostruct($/) { 
            make $<expression>.made
        }

        method expression-noblock($/) { 

            make $<expression>.made
        }

        method base-expression($/) {
            make BaseExpression.new(
                outer-attributes => $<outer-attribute>>>.made,
                expression-item  => $<expression-item>.made,
                text             => $/.Str,
            )
        }

        method suffixed-expression-suffix:sym<method-call>($/) {
            make MethodCallExpressionSuffix.new(
                path-expr-segment => $<path-expr-segment>.made,
                maybe-call-params => $<call-params>.made,
                text              => $/.Str,
            )
        }

        method suffixed-expression-suffix:sym<index>($/) {
            make IndexExpressionSuffix.new(
                expression => $<expression>.made,
                text       => $/.Str,
            )
        }

        method suffixed-expression-suffix:sym<field>($/) {
            make FieldExpressionSuffix.new(
                identifier => $<identifier>.made,
                text       => $/.Str,
            )
        }

        method call-params($/) {
            make $<expression>>>.made
        }

        method suffixed-expression-suffix:sym<call>($/) {
            make CallExpressionSuffix.new(
                maybe-call-params => $<call-params>.made,
                text              => $/.Str,
            )
        }

        method suffixed-expression-suffix:sym<await>($/) {
            make AwaitExpressionSuffix.new
        }

        method suffixed-expression-suffix:sym<tuple-index>($/) {
            make TupleIndexExpressionSuffix.new(
                tuple-index => $<tuple-index>.made,
                text        => $/.Str,
            )
        }

        method suffixed-expression-suffix:sym<error-propagation>($/) {
            make ErrorPropagationExpressionSuffix.new
        }

        method suffixed-expression($/) {
            make SuffixedExpression.new(
                base-expression            => $<base-expression>.made,
                suffixed-expression-suffix => $<suffixed-expression-suffix>>>.made,
                text                       => $/.Str,
            )
        }

        #--------------------
        method unary-prefix:sym<bang>($/) {
            make UnaryPrefixBang.new
        }

        method unary-prefix:sym<minus>($/) {
            make UnaryPrefixMinus.new
        }

        method unary-prefix:sym<star>($/) {
            make UnaryPrefixStar.new
        }

        method unary-expression($/) {
            my @prefixes = $<unary-prefix>>>.made;
            my $expr     = $<suffixed-expression>.made;

            if @prefixes.elems gt 0 {

                make UnaryExpression.new(
                    unary-prefixes      => @prefixes,
                    suffixed-expression => $expr,
                    text                => $/.Str,
                )

            } else {
                make $expr

            }
        }

        method borrow-expression-prefix($/) {
            make BorrowExpressionPrefix.new(
                borrow-count => $/<tok-and>.List.elems,
                mutable      => so $/<kw-mut>:exists,
                text         => $/.Str,
            )
        }

        method borrow-expression($/) {

            my @prefixes = $<borrow-expression-prefix>>>.made;
            my $expr     = $<unary-expression>.made;

            if @prefixes.elems gt 0 {
                make BorrowExpression.new(
                    borrow-expression-prefixes => @prefixes,
                    unary-expression           => $expr,
                    text                       => $/.Str,
                )
            } else {

                make $expr

            }
        }

        method cast-expression($/) {

            my @targets = $<type-no-bounds>>>.made;
            my $expr    = $<borrow-expression>.made;

            if @targets.elems gt 0 {
                make CastExpression.new(
                    borrow-expression => $expr,
                    cast-targets      => @targets,
                    text              => $/.Str,
                )
            } else {
                make $expr
            }
        }

        #---------------------------------------
        # token multiplicative-operator:sym<*> { <star> }
        method multiplicative-operator:sym<*>($/) {
            make MultiplicativeOperator::Star.new
        }

        # token multiplicative-operator:sym</> { <div_> }
        method multiplicative-operator:sym</>($/) {
            make MultiplicativeOperator::Slash.new
        }

        # token multiplicative-operator:sym<%> { <mod_> }
        method multiplicative-operator:sym<%>($/) {
            make MultiplicativeOperator::Mod.new
        }

        # rule multiplicative-expression { <cast-expression> <multiplicative-expression-tail>* }
        method multiplicative-expression($/) {
            my $base = $<cast-expression>.made;
            my @tail = $<multiplicative-expression-tail>>>.made.List;

            if @tail.elems gt 0 {
                make MultiplicativeExpression.new(
                    cast-expression                => $base,
                    multiplicative-expression-tail => @tail,
                    text                           => ~$/,
                )
            } else {
                make $base
            }
        }

        # rule multiplicative-expression-tail { <multiplicative-operator> <cast-expression> } 
        method multiplicative-expression-tail($/) {
            make MultiplicativeExpressionTail.new(
                multiplicative-operator => $<multiplicative-operator>.made,
                cast-expression         => $<cast-expression>.made,
                text                    => ~$/,
            )
        }

        #---------------------------------------
        # token additive-operator:sym<plus> { <plus> }
        method additive-operator:sym<plus>($/) {
            make AdditiveOperator::Plus.new
        }

        # token additive-operator:sym<minus> { <minus> } 
        method additive-operator:sym<minus>($/) {
            make AdditiveOperator::Minus.new
        }

        # rule additive-expression-tail { <additive-operator> <multiplicative-expression> }
        method additive-expression-tail($/) {
            make AdditiveExpressionTail.new(
                additive-operator         => $<additive-operator>.made,
                multiplicative-expression => $<multiplicative-expression>.made,
                text                      => ~$/,
            )
        }

        # rule additive-expression { <multiplicative-expression> <additive-expression-tail>* }
        method additive-expression($/) {
            my $base = $<multiplicative-expression>.made;
            my @tail = $<additive-expression-tail>>>.made.List;

            if @tail.elems gt 0 {
                make AdditiveExpression.new(
                    multiplicative-expression => $base,
                    additive-expression-tail  => @tail,
                    text => ~$/,
                )

            } else {
                make $base
            }
        }

        #---------------------------
        # rule shift-expression-tail { <binary-shift-operator> <additive-expression> }
        method binary-shift-expression-tail($/) {
            make BinaryShiftExpressionTail.new(
                shift-operator      => $<binary-shift-operator>.made,
                additive-expression => $<additive-expression>.made,
                text                => ~$/,
            )
        }

        # rule shift-expression { <additive-expression> <binary-shift-expression-tail>* } 
        method binary-shift-expression($/) {

            my $base = $<additive-expression>.made;
            my @tail = $<binary-shift-expression-tail>>>.made.List;

            if @tail.elems gt 0 {

                make BinaryShiftExpression.new(
                    additive-expression   => $base,
                    shift-expression-tail => @tail,
                    text                  => ~$/,
                )

            } else {

                make $base
            }
        }

        # rule shift-operator:sym<right> { <.greater> <.greater> }
        method binary-shift-operator:sym<right>($/) {
            make BinaryShiftOperator::Right.new
        }

        # rule shift-operator:sym<left> { <.less> <.less> } 
        method binary-shift-operator:sym<left>($/) {
            make BinaryShiftOperator::Left.new
        }

        #---------------------------
        method binary-and-expression($/) {
            my @exprs = $<binary-shift-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make BinaryAndExpression.new(
                    binary-shift-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method binary-xor-expression($/) {
            my @exprs = $<binary-and-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make BinaryXorExpression.new(
                    binary-and-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method binary-or-expression($/) {
            my @exprs = $<binary-xor-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make BinaryOrExpression.new(
                    binary-xor-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        #--------------------
        method binary-le-expression($/) {

            my @exprs = $<binary-or-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make BinaryLeExpression.new(
                    binary-or-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method binary-ge-expression($/) {
            my @exprs = $<binary-le-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make BinaryGeExpression.new(
                    binary-le-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method binary-lt-expression($/) {
            my @exprs = $<binary-ge-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make BinaryLtExpression.new(
                    binary-ge-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method binary-gt-expression($/) {
            my @exprs = $<binary-lt-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make BinaryGtExpression.new(
                    binary-lt-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method binary-ne-expression($/) {
            my @exprs = $<binary-gt-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make BinaryNeExpression.new(
                    binary-gt-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method binary-eqeq-expression($/) {

            my @exprs = $<binary-ne-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make BinaryEqEqExpression.new(
                    binary-ne-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method binary-andand-expression($/) {

            my @exprs = $<binary-eqeq-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make BinaryAndAndExpression.new(
                    binary-eqeq-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method binary-oror-expression($/) {

            my @exprs = $<binary-andand-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make BinaryOrOrExpression.new(
                    binary-andand-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        #--------------------
        method range-expression:sym<full-eq>($/) { 

            my @exprs = $<binary-oror-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make RangeExpressionFullEq.new(
                    binary-oror-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method range-expression:sym<full>($/) {  
            my @exprs = $<binary-oror-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make RangeExpressionFull.new(
                    binary-oror-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method range-expression:sym<to>($/) {  
            my @exprs = $<binary-oror-expression>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make RangeExpressionTo.new(
                    binary-oror-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method range-expression:sym<to-eq>($/) {  

            my $expr = $<binary-oror-expression>.made;

            make RangeExpressionToEq.new(
                binary-oror-expression => $expr,
                text => $/.Str,
            )
        }

        method range-expression:sym<from>($/) {  

            my $expr = $<binary-oror-expression>.made;

            make RangeExpressionFrom.new(
                binary-oror-expression => $expr,
                text => $/.Str,
            )
        }

        method range-expression:sym<open>($/) {  
            make RangeExpressionOpen.new
        }

        method range-expression:sym<base>($/) {  
            make $<binary-oror-expression>.made
        }

        #--------------------

        method shreq-expression($/) {

            my @exprs = $<range-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make ShrEqExpression.new(
                    range-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method shleq-expression($/) {

            my @exprs = $<shreq-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make ShlEqExpression.new(
                    shreq-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method xoreq-expression($/) {

            my @exprs = $<shleq-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make XorEqExpression.new(
                    shleq-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method oreq-expression($/) {

            my @exprs = $<xoreq-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make OrEqExpression.new(
                    xoreq-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method andeq-expression($/) {

            my @exprs = $<oreq-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make AndEqExpression.new(
                    oreq-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method modeq-expression($/) {

            my @exprs = $<andeq-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make ModEqExpression.new(
                    andeq-expressions => @exprs,
                    text => $/.Str,
                )

            } else {


                make @exprs[0]
            }
        }

        method slasheq-expression($/) {

            my @exprs = $<modeq-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make SlashEqExpression.new(
                    modeq-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method stareq-expression($/) {

            my @exprs = $<slasheq-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make StarEqExpression.new(
                    slasheq-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method minuseq-expression($/) {

            my @exprs = $<stareq-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make MinusEqExpression.new(
                    stareq-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method addeq-expression($/) {

            my @exprs = $<minuseq-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make AddEqExpression.new(
                    minuseq-expressions => @exprs,
                    text => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method assign-expression($/) {

            my @exprs = $<addeq-expression>>>.made;

            die if not @exprs.elems gt 0;

            if @exprs.elems gt 1 {

                make AssignExpression.new(
                    addeq-expressions => @exprs,
                    text              => $/.Str,
                )

            } else {

                make @exprs[0]
            }
        }

        method expression($/) {
            make $<assign-expression>.made;
        }

        method maybe-commented-expression($/) {

            if $/<comment>:exists {

                make CommentedExpression.new(
                    comment    => $<comment>.made,
                    expression => $<expression>.made,
                )

            } else {

                make $<expression>.made;
            }
        }

        #-------------------------
        method expression-item:sym<block>($/) { 
            make $<expression-with-block>.made
        }

        method expression-item:sym<macro>($/) { 
            make $<macro-expression>.made
        }

        method expression-item:sym<struct>($/) { 
            make $<struct-expression>.made
        }

        method expression-item:sym<literal>($/)      { make $<literal-expression>.made } 

        method expression-item:sym<path>($/)         { make $<path-expression>.made    }

        method expression-item:sym<grouped>($/)  { 
            make GroupedExpression.new(
                expression => $<expression>.made,
                text       => $/.Str,
            )
        }

        method expression-item:sym<array>($/)        { make $<array-expression>.made   }
        method expression-item:sym<tuple>($/)        { make $<tuple-expression>.made   }
        method expression-item:sym<closure>($/)      { make $<closure-expression>.made } 
        method expression-item:sym<continue>($/)     { make $<continue-expression>.made } 
        method expression-item:sym<break>($/)        { make $<break-expression>.made } 
        method expression-item:sym<return>($/)       { make $<return-expression>.made } 

        #-------------------------
        method expression-with-block:sym<block>($/)        { make $<block-expression>.made }
        method expression-with-block:sym<match>($/)        { make $<match-expression>.made }
        method expression-with-block:sym<async-block>($/)  { make $<async-block-expression>.made }
        method expression-with-block:sym<unsafe-block>($/) { make $<unsafe-block-expression>.made }
        method expression-with-block:sym<loop>($/)         { make $<loop-expression>.made }
        method expression-with-block:sym<if>($/)           { make $<if-expression>.made }
        method expression-with-block:sym<if-let>($/)       { make $<if-let-expression>.made }
        method expression-with-block:sym<comment>($/)      { make $<comment>.made }
    }
}
