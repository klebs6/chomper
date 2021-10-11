use translator;

class Operator {

    has Str     $.symbol      is required;
    has Numeric $.precedence  is required;

    method new(Str $symbol, Numeric $precedence) {
        self.bless(:$symbol, :$precedence);
    }
}

our class SimpleIfdef::Actions {

    method translate-to-cfg-predicate(@stack) {

        if @stack.elems eq 1 and @stack[0] ~~ Str {
            return @stack[0].Str;
        }

        my $cur = Nil;

        for @stack {
            my $op = $_[0];
            my $l  = $_[1];
            my $r  = $_[2];
            $cur = do if $l {
                given $op.symbol {
                    when "&&" {
                        "all($l,$r)";
                    }
                    when "||" {
                        "any($l,$r)";
                    }
                }
            } else {
                given $op.symbol {
                    when "&&" {
                        "all($cur,$r)";
                    }
                    when "||" {
                        "any($cur,$r)";
                    }
                }
            };
        }
        ~$cur
    }

    method expr-stack(@tokens) {
        sub opp-reduce(@stack) {
            my ($term1, $op, $term2) = @stack.splice(*-3, 3);
            @stack.push([$op, $term1, $term2]);
        }

        my %prec = 
        '+'   => 1, 
        '-'   => 1,
        '*'   => 2, 
        '/'   => 2,
        '**'  => 3;

        my @stack = @tokens[0];

        for @tokens[1..*] -> $op, $term {
            opp-reduce(@stack)
                while @stack >= 3
                   && $op.precedence <= @stack[*-2].precedence;
            @stack.push($op, $term);
        }

        opp-reduce(@stack) while @stack > 1;

        return @stack[0];
    }

    method simple-ifdef($/) {

        my $pred = $/<ifdef-expression>.made;

        if $/<ifdef>:exists {
            make "#[cfg($pred)]"

        } else { #ifndef

            make "#[cfg(not($pred))]"
        }
    }

    method ifdef-expression($/) {
        my @tokens = $/.caps.map({.value.made});
        my @stack = self.expr-stack(@tokens);
        make self.translate-to-cfg-predicate(@stack)
    }

    method ifdef-term:sym<parenthesized>($/) {
        make $<ifdef-expression>.made;
    }

    method ifdef-term:sym<identifier>($/) {
        make $/<identifier>.made;
    }

    method ifdef-infix:sym<&&>($/)  { make Operator.new(~$<sym>, 1) }
    method ifdef-infix:sym<||>($/)  { make Operator.new(~$<sym>, 2) }

    method identifier($/) { make $/.Str }
}

our sub translate-simple-ifdef( $submatch, $body, $rclass) {

    Translator.parse(
        $submatch.orig.trim.Str, 
        rule    => "simple-ifdef", 
        actions => SimpleIfdef::Actions).made

}
