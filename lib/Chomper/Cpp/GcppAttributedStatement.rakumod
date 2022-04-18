unit module Chomper::Cpp::GcppAttributedStatement;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppStatement;
use Chomper::Cpp::GcppTry;
use Chomper::Cpp::GcppAttr;

# token statement:sym<attributed> { 
#   <comment>? 
#   <attribute-specifier-seq>? 
#   <attributed-statement-body> 
# }
class AttributedStatement does IStatement is export {
    has IComment  $.comment is rw;
    has           @.attribute-specifier-seq is rw;
    has           $.attributed-statement-body is required is rw;

    has $.text;

    method name {
        'AttributedStatement'
    }

    method gist(:$treemark=False) {

        my $builder = "";

        if $.comment {
            $builder ~= $.comment.gist(:$treemark) ~ "\n";
        }

        for @.attribute-specifier-seq {
            $builder ~= $_.gist(:$treemark) ~ "\n";
        }

        $builder ~= $.attributed-statement-body.gist(:$treemark);

        $builder
    }
}

package AttributedStatementBody is export {

    # rule attributed-statement-body:sym<expression> { 
    #   <expression-statement> 
    # }
    our class Expression does IAttributedStatementBody {

        has ExpressionStatement $.expression-statement is required;

        has $.text;

        method name {
            'AttributedStatementBody::Expression'
        }

        method gist(:$treemark=False) {
            $.expression-statement.gist(:$treemark)
        }
    }

    # rule attributed-statement-body:sym<compound> { 
    #   <compound-statement> 
    # }
    our class Compound does IAttributedStatementBody {

        has CompoundStatement $.compound-statement is required;

        has $.text;

        method name {
            'AttributedStatementBody::Compound'
        }

        method gist(:$treemark=False) {
            $.compound-statement.gist(:$treemark)
        }
    }

    # rule attributed-statement-body:sym<selection> { 
    #   <selection-statement> 
    # }
    our class Selection does IAttributedStatementBody {

        has ISelectionStatement $.selection-statement is required;

        has $.text;

        method name {
            'AttributedStatementBody::Selection'
        }

        method gist(:$treemark=False) {
            $.selection-statement.gist(:$treemark)
        }
    }

    # rule attributed-statement-body:sym<iteration> { 
    #   <iteration-statement> 
    # }
    our class Iteration does IAttributedStatementBody {

        has IIterationStatement $.iteration-statement is required;

        has $.text;

        method name {
            'AttributedStatementBody::Iteration'
        }

        method gist(:$treemark=False) {
            $.iteration-statement.gist(:$treemark)
        }
    }

    # rule attributed-statement-body:sym<jump> { 
    #   <jump-statement> 
    # }
    our class Jump does IAttributedStatementBody {

        has IJumpStatement $.jump-statement is required;

        has $.text;

        method name {
            'AttributedStatementBody::Jump'
        }

        method gist(:$treemark=False) {
            $.jump-statement.gist(:$treemark)
        }
    }

    # rule attributed-statement-body:sym<try> { 
    #   <try-block> 
    # }
    our class Try does IAttributedStatementBody {

        has TryBlock $.try-block is required;

        has $.text;

        method name {
            'AttributedStatementBody::Try'
        }

        method gist(:$treemark=False) {
            $.try-block.gist(:$treemark)
        }
    }
}

package AttributedStatementGrammar is export {

    our role Actions {

        # token statement:sym<attributed> { <comment>? <attribute-specifier-seq>? <attributed-statement-body> }
        method statement:sym<attributed>($/) {

            my $comment = $<comment>.made;
            my $attribs = $<attribute-specifier-seq>.made;
            my $body    = $<attributed-statement-body>.made;

            if not $comment and not $attribs {

                make $body

            } else {

                my $res = AttributedStatement.new(
                    attributed-statement-body => $body,
                );

                if $comment {
                    $res.comment = $comment;
                }

                if $attribs {
                    $res.attribute-specifier-seq = $attribs;
                }

                make $res
            }
        }

        # rule attributed-statement-body:sym<expression> { <expression-statement> }
        method attributed-statement-body:sym<expression>($/) {
            make $<expression-statement>.made;
        }

        # rule attributed-statement-body:sym<compound> { <compound-statement> }
        method attributed-statement-body:sym<compound>($/) {
            make $<compound-statement>.made;
        }

        # rule attributed-statement-body:sym<selection> { <selection-statement> }
        method attributed-statement-body:sym<selection>($/) {
            make $<selection-statement>.made
        }

        # rule attributed-statement-body:sym<iteration> { <iteration-statement> }
        method attributed-statement-body:sym<iteration>($/) {
            make $<iteration-statement>.made
        }

        # rule attributed-statement-body:sym<jump> { <jump-statement> }
        method attributed-statement-body:sym<jump>($/) {
            make $<jump-statement>.made
        }

        # rule attributed-statement-body:sym<try> { <try-block> } 
        method attributed-statement-body:sym<try>($/) {
            make $<try-block>.made
        }
    }

    our role Rules {

        token statement:sym<attributed> { 
            <comment>?
            <attribute-specifier-seq>?
            <attributed-statement-body>
        }

        proto rule attributed-statement-body { * }
        rule attributed-statement-body:sym<expression> { <expression-statement> }
        rule attributed-statement-body:sym<compound>   { <compound-statement>   }
        rule attributed-statement-body:sym<selection>  { <selection-statement>  }
        rule attributed-statement-body:sym<iteration>  { <iteration-statement>  }
        rule attributed-statement-body:sym<jump>       { <jump-statement>       }
        rule attributed-statement-body:sym<try>        { <try-block>            }
    }
}
