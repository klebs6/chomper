our sub wrap-comment($text) {

    my @builder;

    @builder.push: "/**";

    my @lines = $text.split("\n");

    for @lines -> $line {
        @builder.push: "  | $line";
    }

    @builder.push: "  |";
    @builder.push: "  */";
    @builder.join("\n")
}
