unit module Chomper::Rust::GrustWhereClause;

use Data::Dump::Tree;

class WhereClause is export {
    has @.where-clause-items;

    has $.text;

    method gist {

        my $builder = "where ";

        for @.where-clause-items {
            $builder ~= $_.gist ~ ", ";
        }

        $builder
    }
}

class WhereClauseItemLifetime is export {
    has $.lifetime;
    has $.lifetime-bounds;

    has $.text;

    method gist {
        $.lifetime.gist ~ ":" ~ $.lifetime-bounds.gist
    }
}

class WhereClauseItemTypeBound is export {
    has $.maybe-for-lifetimes;
    has $.type;
    has $.maybe-type-param-bounds;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-for-lifetimes {
            $builder ~= $.maybe-for-lifetimes.gist;
        }

        $builder ~= " " ~ $.type.gist ~ ": ";

        if $.maybe-type-param-bounds {
            $builder ~= $.maybe-type-param-bounds.gist;
        }

        $builder
    }
}

package WhereClauseGrammar is export {

    our role Rules {

        rule where-clause {
            <kw-where>
            [<where-clause-item>* %% <tok-comma>]
        }

        proto rule where-clause-item { * }

        rule where-clause-item:sym<lt> {
            <lifetime> 
            <tok-colon> 
            <lifetime-bounds>
        }

        rule where-clause-item:sym<type-bound> {
            <for-lifetimes>? 
            <type> 
            <tok-colon> 
            <type-param-bounds>?
        }
    }

    our role Actions {

        method where-clause($/) {
            make WhereClause.new(
                where-clause-items => $<where-clause-item>>>.made,
                text               => $/.Str,
            )
        }

        method where-clause-item:sym<lt>($/) {
            make WhereClauseItemLifetime.new(
                lifetime        => $<lifetime>.made,
                lifetime-bounds => $<lifetime-bounds>.made,
                text            => $/.Str,
            )
        }

        method where-clause-item:sym<type-bound>($/) {
            make WhereClauseItemTypeBound.new(
                maybe-for-lifetimes     => $<for-lifetimes>.made,
                type                    => $<type>.made,
                maybe-type-param-bounds => $<type-param-bounds>.made,
                text                    => $/.Str,
            )
        }
    }
}
