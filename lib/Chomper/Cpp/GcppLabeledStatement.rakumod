unit module Chomper::Cpp::GcppLabeledStatement;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppIdent;
use Chomper::Cpp::GcppAttr;

package LabeledStatementLabelBody is export {

    # rule labeled-statement-label-body:sym<id> { 
    #   <identifier> 
    # }
    our class Id 
    does ILabeledStatementLabelBody {

        has Identifier $.identifier is required;

        has $.text;

        method gist(:$treemark=False) {
            $.identifier.gist(:$treemark)
        }
    }

    # rule labeled-statement-label-body:sym<case-expr> { 
    #   <case> 
    #   <constant-expression> 
    # }
    our class CaseExpr 
    does ILabeledStatementLabelBody {

        has IConstantExpression $.constant-expression is required;

        has $.text;

        method gist(:$treemark=False) {
            "case " ~ $.constant-expression.gist(:$treemark)
        }
    }

    # rule labeled-statement-label-body:sym<default> { 
    #   <default_> 
    # }
    our class Default_ does ILabeledStatementLabelBody {

        has $.text;

        method gist(:$treemark=False) {
            "default"
        }
    }
}

# rule labeled-statement-label { 
#   <attribute-specifier-seq>? 
#   <labeled-statement-label-body> 
#   <colon> 
# }
class LabeledStatementLabel is export {
    has IAttributeSpecifierSeq     $.attribute-specifier-seq;
    has ILabeledStatementLabelBody $.labeled-statement-label-body is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        my $a = $.attribute-specifier-seq;

        if $a {
            $builder ~= $a.gist(:$treemark) ~ " ";
        }

        $builder ~= $.labeled-statement-label-body.gist(:$treemark);

        $builder ~ ":"
    }
}

# rule labeled-statement { 
#   <labeled-statement-label> 
#   <statement> 
# }
class LabeledStatement does IStatement is export {
    has LabeledStatementLabel $.labeled-statement-label is required;
    has IStatement            $.statement is required;

    has $.text;

    method gist(:$treemark=False) {
        $.labeled-statement-label.gist(:$treemark) ~ " " ~ $.statement.gist(:$treemark)
    }
}

package LabeledStatementGrammar is export {

    our role Actions {

        # token statement:sym<labeled> { 
        #   <comment>? 
        #   <labeled-statement> 
        # }
        method statement:sym<labeled>($/) {

            my $comment = $<comment>.made;
            my $body    = $<labeled-statement>.made;

            if not $comment {

                make $body

            } else {

                make Statement::Labeled.new(
                    comment           => $comment,
                    labeled-statement => $body,
                    text              => ~$/,
                )
            }
        }

        # rule labeled-statement-label-body:sym<id> { <identifier> }
        method labeled-statement-label-body:sym<id>($/) {
            make $<identifier>.made
        }

        # rule labeled-statement-label-body:sym<case-expr> { <case> <constant-expression> }
        method labeled-statement-label-body:sym<case-expr>($/) {
            make LabeledStatementLabelBody::CaseExpr.new(
                constant-expression => $<constant-expression>.made,
                text                => ~$/,
            )
        }

        # rule labeled-statement-label-body:sym<default> { <default_> } 
        method labeled-statement-label-body:sym<default>($/) {
            make LabeledStatementLabelBody::Default_.new
        }

        # rule labeled-statement-label { <attribute-specifier-seq>? <labeled-statement-label-body> <colon> }
        method labeled-statement-label($/) {
            make LabeledStatementLabel.new(
                attribute-specifier-seq      => $<attribute-specifier-seq>.made,
                labeled-statement-label-body => $<labeled-statement-label-body>.made,
                text                         => ~$/,
            )
        }

        # rule labeled-statement { <labeled-statement-label> <statement> }
        method labeled-statement($/) {
            make LabeledStatement.new(
                labeled-statement-label => $<labeled-statement-label>.made,
                statement               => $<statement>.made,
                text                    => ~$/,
            )
        }
    }

    our role Rules {

        proto rule labeled-statement-label-body { * }
        rule labeled-statement-label-body:sym<id>        { <identifier>                }
        rule labeled-statement-label-body:sym<case-expr> { <case> <constant-expression> }
        rule labeled-statement-label-body:sym<default>   { <default_>                   }

        #-----------------------------
        rule labeled-statement-label {
            <attribute-specifier-seq>?
            <labeled-statement-label-body>
            <colon>
        }

        rule labeled-statement {
            <labeled-statement-label>
            <statement>
        }
    }
}
