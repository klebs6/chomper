unit module Chomper::Cpp::GcppOperator;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

package TheOperator is export {

    # token the-operator:sym<new> { 
    #   <new_> 
    #   [ <.left-bracket> <.right-bracket>]? 
    # }
    our class New does ITheOperator { 

        has Bool $.has-brackets is required;
        has $.text;

        method name {
            'TheOperator::New'
        }

        method gist(:$treemark=False) {
            if $.has-brackets {
                "new[]"
            } else {
                "new"
            }
        }
    }

    # token the-operator:sym<delete> { 
    #   <delete> 
    #   [ <.left-bracket> <.right-bracket>]? 
    # }
    our class Delete does ITheOperator { 

        has Bool $.has-brackets is required;

        has $.text;

        method name {
            'TheOperator::Delete'
        }

        method gist(:$treemark=False) {
            if $.has-brackets {
                "delete[]" 
            } else {
                "delete" 
            }
        }
    }

    # token the-operator:sym<plus> { <plus> }
    our class Plus does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Plus'
        }

        method gist(:$treemark=False) {
            "+"
        }
    }

    # token the-operator:sym<minus> { <minus> }
    our class Minus does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Minus'
        }

        method gist(:$treemark=False) {
            "-"
        }
    }

    # token the-operator:sym<star> { <star> }
    our class Star does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Star'
        }

        method gist(:$treemark=False) {
            "*"
        }
    }

    # token the-operator:sym<div_> { <div_> }
    our class Div does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Div'
        }

        method gist(:$treemark=False) {
            "/"
        }
    }

    # token the-operator:sym<mod_> { <mod_> }
    our class Mod does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Mod'
        }

        method gist(:$treemark=False) {
            "%"
        }
    }

    # token the-operator:sym<caret> { <caret> }
    our class Caret does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Caret'
        }

        method gist(:$treemark=False) {
            "^"
        }
    }

    # token the-operator:sym<and_> { <and_> <!before <and_>> }
    our class And does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::And'
        }

        method gist(:$treemark=False) {
            "&"
        }
    }

    # token the-operator:sym<or_> { <or_> }
    our class Or does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Or'
        }

        method gist(:$treemark=False) {
            "|"
        }
    }

    # token the-operator:sym<tilde> { <tilde> }
    our class Tilde does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Tilde'
        }

        method gist(:$treemark=False) {
            "~"
        }
    }

    # token the-operator:sym<not> { <not_> }
    our class Not does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Not'
        }

        method gist(:$treemark=False) {
            "!"
        }
    }

    # token the-operator:sym<assign> { <assign> }
    our class Assign does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Assign'
        }

        method gist(:$treemark=False) {
            "="
        }
    }

    # token the-operator:sym<greater> { <greater> }
    our class Greater does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Greater'
        }

        method gist(:$treemark=False) {
            ">"
        }
    }

    # token the-operator:sym<less> { <less> }
    our class Less does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Less'
        }

        method gist(:$treemark=False) {
            "<"
        }
    }

    # token the-operator:sym<greater-equal> { <greater-equal> }
    our class GreaterEqual does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::GreaterEqual'
        }

        method gist(:$treemark=False) {
            ">="
        }
    }

    # token the-operator:sym<plus-assign> { <plus-assign> }
    our class PlusAssign does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::PlusEqual'
        }

        method gist(:$treemark=False) {
            "+="
        }
    }

    # token the-operator:sym<minus-assign> { <minus-assign> }
    our class MinusAssign does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::MinusAssign'
        }

        method gist(:$treemark=False) {
            "-="
        }
    }

    # token the-operator:sym<star-assign> { <star-assign> }
    our class StarAssign does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::StarAssign'
        }

        method gist(:$treemark=False) {
            "*="
        }
    }

    # token the-operator:sym<mod-assign> { <mod-assign> }
    our class ModAssign does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::ModAssign'
        }

        method gist(:$treemark=False) {
            "%="
        }
    }

    # token the-operator:sym<xor-assign> { <xor-assign> }
    our class XorAssign does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::XorAssign'
        }

        method gist(:$treemark=False) {
            "^="
        }
    }

    # token the-operator:sym<and-assign> { <and-assign> }
    our class AndAssign does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::AndAssign'
        }

        method gist(:$treemark=False) {
            "&="
        }
    }

    # token the-operator:sym<or-assign> { <or-assign> }
    our class OrAssign does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::OrAssign'
        }

        method gist(:$treemark=False) {
            "|="
        }
    }

    # token the-operator:sym<LessLess> { <less> <less> }
    our class LessLess does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::LessLess'
        }

        method gist(:$treemark=False) {
            "<<"
        }
    }

    # token the-operator:sym<GreaterGreater> { <greater> <greater> }
    our class GreaterGreater does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::GreaterGreater'
        }

        method gist(:$treemark=False) {
            ">>"
        }
    }

    # token the-operator:sym<right-shift-assign> { <right-shift-assign> }
    our class RightShiftAssign does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::RightShiftAssign'
        }

        method gist(:$treemark=False) {
            ">>="
        }
    }

    # token the-operator:sym<left-shift-assign> { <left-shift-assign> }
    our class LeftShiftAssign does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::LeftShiftAssign'
        }

        method gist(:$treemark=False) {
            "<<="
        }
    }

    # token the-operator:sym<equal> { <equal> }
    our class Equal does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Equal'
        }

        method gist(:$treemark=False) {
            "=="
        }
    }

    # token the-operator:sym<not-equal> { <not-equal> }
    our class NotEqual does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::NotEqual'
        }

        method gist(:$treemark=False) {
            "!="
        }
    }

    # token the-operator:sym<less-equal> { <less-equal> }
    our class LessEqual does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::LessEqual'
        }

        method gist(:$treemark=False) {
            "<="
        }
    }

    # token the-operator:sym<and-and> { <and-and> }
    our class AndAnd does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::AndAnd'
        }

        method gist(:$treemark=False) {
            "&&"
        }
    }

    # token the-operator:sym<or-or> { <or-or> }
    our class OrOr does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::OrOr'
        }

        method gist(:$treemark=False) {
            "||"
        }
    }

    # token the-operator:sym<plus-plus> { <plus-plus> }
    our class PlusPlus does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::PlusPlus'
        }

        method gist(:$treemark=False) {
            "++"
        }
    }

    # token the-operator:sym<minus-minus> { <minus-minus> }
    our class MinusMinus does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::MinusMinus'
        }

        method gist(:$treemark=False) {
            "--"
        }
    }

    # token the-operator:sym<comma> { <.comma> }
    our class Comma does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Comma'
        }

        method gist(:$treemark=False) {
            ","
        }
    }

    # token the-operator:sym<arrow-star> { <arrow-star> }
    our class ArrowStar does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::ArrowStar'
        }

        method gist(:$treemark=False) {
            "->*"
        }
    }

    # token the-operator:sym<arrow> { <arrow> }
    our class Arrow does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Arrow'
        }

        method gist(:$treemark=False) {
            "->"
        }
    }

    # token the-operator:sym<Parens> { <.left-paren> <.right-paren> }
    our class Parens does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Parens'
        }

        method gist(:$treemark=False) {
            "()"
        }
    }

    # token the-operator:sym<Brak> { <.left-bracket> <.right-bracket> }
    our class Brak does ITheOperator { 
        has $.text;

        method name {
            'TheOperator::Brak'
        }

        method gist(:$treemark=False) {
            "[]"
        }
    }
}

package OperatorGrammar is export {

    our role Actions {

        # token the-operator:sym<new> { 
        #   <new_> 
        #   [ <.left-bracket> <.right-bracket>]? 
        # }
        method the-operator:sym<new>($/) {
            make TheOperator::New.new
        }

        # token the-operator:sym<delete> { 
        #   <delete> 
        #   [ <.left-bracket> <.right-bracket>]? 
        # }
        method the-operator:sym<delete>($/) {
            make TheOperator::Delete.new
        }

        # token the-operator:sym<plus> { <plus> }
        method the-operator:sym<plus>($/) {
            make TheOperator::Plus.new
        }

        # token the-operator:sym<minus> { <minus> }
        method the-operator:sym<minus>($/) {
            make TheOperator::Minus.new
        }

        # token the-operator:sym<star> { <star> }
        method the-operator:sym<star>($/) {
            make TheOperator::Star.new
        }

        # token the-operator:sym<div_> { <div_> }
        method the-operator:sym<div_>($/) {
            make TheOperator::Div.new
        }

        # token the-operator:sym<mod_> { <mod_> }
        method the-operator:sym<mod_>($/) {
            make TheOperator::Mod.new
        }

        # token the-operator:sym<caret> { <caret> }
        method the-operator:sym<caret>($/) {
            make TheOperator::Caret.new
        }

        # token the-operator:sym<and_> { <and_> <!before <and_>> }
        method the-operator:sym<and_>($/) {
            make TheOperator::And.new
        }

        # token the-operator:sym<or_> { <or_> }
        method the-operator:sym<or_>($/) {
            make TheOperator::Or.new
        }

        # token the-operator:sym<tilde> { <tilde> }
        method the-operator:sym<tilde>($/) {
            make TheOperator::Tilde.new
        }

        # token the-operator:sym<not> { <not_> }
        method the-operator:sym<not>($/) {
            make TheOperator::Not.new
        }

        # token the-operator:sym<assign> { <assign> }
        method the-operator:sym<assign>($/) {
            make TheOperator::Assign.new
        }

        # token the-operator:sym<greater> { <greater> }
        method the-operator:sym<greater>($/) {
            make TheOperator::Greater.new
        }

        # token the-operator:sym<less> { <less> }
        method the-operator:sym<less>($/) {
            make TheOperator::Less.new
        }

        # token the-operator:sym<greater-equal> { <greater-equal> }
        method the-operator:sym<greater-equal>($/) {
            make TheOperator::GreaterEqual.new
        }

        # token the-operator:sym<plus-assign> { <plus-assign> }
        method the-operator:sym<plus-assign>($/) {
            make TheOperator::PlusAssign.new
        }

        # token the-operator:sym<minus-assign> { <minus-assign> }
        method the-operator:sym<minus-assign>($/) {
            make TheOperator::MinusAssign.new
        }

        # token the-operator:sym<star-assign> { <star-assign> }
        method the-operator:sym<star-assign>($/) {
            make TheOperator::StarAssign.new
        }

        # token the-operator:sym<mod-assign> { <mod-assign> }
        method the-operator:sym<mod-assign>($/) {
            make TheOperator::ModAssign.new
        }

        # token the-operator:sym<xor-assign> { <xor-assign> }
        method the-operator:sym<xor-assign>($/) {
            make TheOperator::XorAssign.new
        }

        # token the-operator:sym<and-assign> { <and-assign> }
        method the-operator:sym<and-assign>($/) {
            make TheOperator::AndAssign.new
        }

        # token the-operator:sym<or-assign> { <or-assign> }
        method the-operator:sym<or-assign>($/) {
            make TheOperator::OrAssign.new
        }

        # token the-operator:sym<LessLess> { <less> <less> }
        method the-operator:sym<LessLess>($/) {
            make TheOperator::LessLess.new
        }

        # token the-operator:sym<GreaterGreater> { <greater> <greater> }
        method the-operator:sym<GreaterGreater>($/) {
            make TheOperator::GreaterGreater.new
        }

        # token the-operator:sym<right-shift-assign> { <right-shift-assign> }
        method the-operator:sym<right-shift-assign>($/) {
            make TheOperator::RightShiftAssign.new
        }

        # token the-operator:sym<left-shift-assign> { <left-shift-assign> }
        method the-operator:sym<left-shift-assign>($/) {
            make TheOperator::LeftShiftAssign.new
        }

        # token the-operator:sym<equal> { <equal> }
        method the-operator:sym<equal>($/) {
            make TheOperator::Equal.new
        }

        # token the-operator:sym<not-equal> { <not-equal> }
        method the-operator:sym<not-equal>($/) {
            make TheOperator::NotEqual.new
        }

        # token the-operator:sym<less-equal> { <less-equal> }
        method the-operator:sym<less-equal>($/) {
            make TheOperator::LessEqual.new
        }

        # token the-operator:sym<and-and> { <and-and> }
        method the-operator:sym<and-and>($/) {
            make TheOperator::AndAnd.new
        }

        # token the-operator:sym<or-or> { <or-or> }
        method the-operator:sym<or-or>($/) {
            make TheOperator::OrOr.new
        }

        # token the-operator:sym<plus-plus> { <plus-plus> }
        method the-operator:sym<plus-plus>($/) {
            make TheOperator::PlusPlus.new
        }

        # token the-operator:sym<minus-minus> { <minus-minus> }
        method the-operator:sym<minus-minus>($/) {
            make TheOperator::MinusMinus.new
        }

        # token the-operator:sym<comma> { <.comma> }
        method the-operator:sym<comma>($/) {
            make TheOperator::Comma.new
        }

        # token the-operator:sym<arrow-star> { <arrow-star> }
        method the-operator:sym<arrow-star>($/) {
            make TheOperator::ArrowStar.new
        }

        # token the-operator:sym<arrow> { <arrow> }
        method the-operator:sym<arrow>($/) {
            make TheOperator::Arrow.new
        }

        # token the-operator:sym<Parens> { <.left-paren> <.right-paren> }
        method the-operator:sym<Parens>($/) {
            make TheOperator::Parens.new
        }

        # token the-operator:sym<Brak> { <.left-bracket> <.right-bracket> }
        method the-operator:sym<Brak>($/) {
            make TheOperator::Brak.new
        }
    }

    our role Rules {

        proto token the-operator   { * }
        token the-operator:sym<new>                { <new_>   [ <left-bracket> <right-bracket>]? } 
        token the-operator:sym<delete>             { <delete> [ <left-bracket> <right-bracket>]? } 
        token the-operator:sym<plus>               { <plus>                                      } 
        token the-operator:sym<minus>              { <minus>                                     } 
        token the-operator:sym<star>               { <star>                                      } 
        token the-operator:sym<div_>               { <div_>                                      } 
        token the-operator:sym<mod_>               { <mod_>                                      } 
        token the-operator:sym<caret>              { <caret>                                     } 
        token the-operator:sym<and_>               { <and_>    <!before <and_>>                  } 
        token the-operator:sym<or_>                { <or_>                                       } 
        token the-operator:sym<tilde>              { <tilde>                                     } 
        token the-operator:sym<not>                { <not_>                                      } 
        token the-operator:sym<assign>             { <assign>                                    } 
        token the-operator:sym<greater>            { <greater>                                   } 
        token the-operator:sym<less>               { <less>                                      } 
        token the-operator:sym<greater-equal>      { <greater-equal>                             } 
        token the-operator:sym<plus-assign>        { <plus-assign>                               } 
        token the-operator:sym<minus-assign>       { <minus-assign>                              } 
        token the-operator:sym<star-assign>        { <star-assign>                               } 
        token the-operator:sym<mod-assign>         { <mod-assign>                                } 
        token the-operator:sym<xor-assign>         { <xor-assign>                                } 
        token the-operator:sym<and-assign>         { <and-assign>                                } 
        token the-operator:sym<or-assign>          { <or-assign>                                 } 
        token the-operator:sym<LessLess>           { <less> <less>                               } 
        token the-operator:sym<GreaterGreater>     { <greater> <greater>                         } 
        token the-operator:sym<right-shift-assign> { <right-shift-assign>                        } 
        token the-operator:sym<left-shift-assign>  { <left-shift-assign>                         } 
        token the-operator:sym<equal>              { <equal>                                     } 
        token the-operator:sym<not-equal>          { <not-equal>                                 } 
        token the-operator:sym<less-equal>         { <less-equal>                                } 
        token the-operator:sym<and-and>            { <and-and>                                   } 
        token the-operator:sym<or-or>              { <or-or>                                     } 
        token the-operator:sym<plus-plus>          { <plus-plus>                                 } 
        token the-operator:sym<minus-minus>        { <minus-minus>                               } 
        token the-operator:sym<comma>              { <comma>                                     } 
        token the-operator:sym<arrow-star>         { <arrow-star>                                } 
        token the-operator:sym<arrow>              { <arrow>                                     } 
        token the-operator:sym<Parens>             { <left-paren>   <right-paren>                } 
        token the-operator:sym<Brak>               { <left-bracket> <right-bracket>              } 
    }
}
