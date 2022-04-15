use Chomper::Vbar;

our class FormulaPNG::Workspace {

    has $.tmpdir = IO::Spec::Unix.tmpdir();

    has $.formula     = 'E=\frac{m_1v^2}{2}';
    has $.formula-tex = $!tmpdir ~ 'formula.' ~ $*PID ~ '.tex';
    has $.formula-pdf = $!tmpdir ~ 'formula.' ~ $*PID ~ '.pdf';
    has $.formula-png = $!tmpdir ~ 'formula.' ~ $*PID ~ '.png';
    has $.density     = 300;
    has $.quality     = 90;
    has $.rerouted    = False;

    has $.formula-tex-text;

    method stamp-texfile {
        $!formula-tex-text = qq:to/END/;
        \\documentclass[border=2pt]\{standalone\}
        \\usepackage\{amsmath\}
        \\usepackage\{array\}
        \\usepackage\{varwidth\}
        \\begin\{document\}
        \\begin\{math\}
        \\begin\{aligned\}
        {$!formula}
        \\end\{aligned\}
        \\end\{math\}
        \\end\{document\}
        END
        $!rerouted = True;
    }

    method strip-eqn-delim {

        my $formula   = $!formula.chomp.trim;

        #sometimes we parse the formula out of doc
        #comments with leading bars
        if each-line-has-leading-vbar($formula) {
            $formula = $formula.subst(:g, rule { ^^ \| }, "");
        }

        my $begin-eqn = '\begin{equation*}';
        my $end-eqn   = '\end{equation*}';

        $formula = $formula.subst(:g, $begin-eqn, "");
        $formula = $formula.subst(:g, $end-eqn,   "");

        $!formula = $formula.chomp.trim;
    }

    method detect-and-reroute-eqnarray {

        self.strip-eqn-delim();

        my $formula = $!formula.chomp.trim;

        my $begin-eqnarray = '\begin{eqnarray*}';
        my $end-eqnarray   = '\end{eqnarray*}';

        if $formula.contains($begin-eqnarray) {

            $formula = $formula.subst($begin-eqnarray, "");
            $formula = $formula.subst($end-eqnarray,   "");
            $formula = $formula.subst(:g, "& = &", "& =");

            $!formula = $formula.chomp.trim;
        }
    }

    method write-tex {
        spurt $!formula-tex, $!formula-tex-text;
    }

    method create-pdf {

        my $cmd = do if not $!rerouted {
            'pdflatex -output-directory=' ~ $!tmpdir ~ ' "\def\formula{' ~ $!formula ~ '}\input{' ~ $!formula-tex ~ '}"'
        } else {
            'pdflatex -output-directory=' ~ $!tmpdir ~ ' "\input{' ~ $!formula-tex ~ '}"'
        };

        qqx{ $cmd };

        if not $!formula-pdf.IO.e {
            say "error generating $!formula-pdf";
        } 
    }

    method create-png {
        my $cmd = "convert -colorspace gray -density $!density $!formula-pdf -quality $!quality $!formula-png";
        qqx/$cmd/;
    }

    method open-png {
        qqx/open $!formula-png/;
    }

    method run {
        self.detect-and-reroute-eqnarray();
        self.stamp-texfile();
        self.write-tex();
        self.create-pdf();
        self.create-png();
        self.open-png();
    }
}
