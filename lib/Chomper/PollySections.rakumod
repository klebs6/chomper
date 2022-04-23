use Data::Dump::Tree;

#aws polly needs requests to be of a certain size
our sub split-into-polly-sections(@lines) {

    @lines
    ==> map({
        $_
        .trim
        .subst(:g, /\s+/, " ")
        .subst(:g, "'", '\"')
    })
    ==> grep({
        $_.chomp.trim !~~ "" 
    })
    ==> join("\n")
    ==> my $text;

    my @builder;

    my @polly-sections = gather for $text.words -> $word {

        @builder.push: $word;

        my Int $chars = [+] @builder>>.chars;

        if $chars > 400 {
            take @builder.join(" ");
            @builder = [];
        }
    };

    @polly-sections.push: @builder.join(" ");

    @polly-sections
}
