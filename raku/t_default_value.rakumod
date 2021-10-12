use grammar;
use test-case;

our sub test-default-values {
    my $active = False; return if not $active;

    my $g = grammar G0 does ParserRules {
        rule TOP {
            <.ws> <default-value>
        }
    };

    TestCase.new(
        grammar => $g,
        examples => [
            '{ Slider::RotaryHorizontalVerticalDrag, Slider::NoTextBox}',
            '{ Slider::RotaryHorizontalVerticalDrag}',
            '0.54'
        ],
        fail-examples => [
            'Slider::RotaryHorizontalVerticalDrag, Slider::NoTextBox',
            '0.54f'
        ]
    ).run();
}

our sub test-struct-member-declaration {
    my $active = True; return if not $active;

    use Grammar::Tracer;
    my $g = grammar G1 does ParserRules {
        rule TOP {
            <.ws> <struct-member-declaration>
        }
    };

    TestCase.new(
        grammar  => $g,
        examples => [
            'Slider rotarySlider    { Slider::RotaryHorizontalVerticalDrag, Slider::NoTextBox};',
        ],
        fail-examples => [ ]
    ).run();
}
