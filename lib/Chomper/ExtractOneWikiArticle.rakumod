use JSON::Fast;

our sub extract-one-wiki-article(:$article) {

    my $fjson  = "/tmp/in.json";
    my $ftex   = "/tmp/in.tex";
    my $fhtml  = "/tmp/in.html";
    my $fplain = "/tmp/in.plain";
    my $fmd    = "/tmp/in.md";

    shell 
    'curl https://en.wikipedia.org/w/api.php\?action\=parse\&format\=json\&page\=' 
    ~ $article 
    ~ '\&prop\=text\&formatversion\=2 > ' 
    ~ $fjson;

    my $json = from-json($fjson.IO.slurp);
    my $html = $json<parse><text>;

    $fhtml.IO.spurt: $html;

    shell "pandoc $fhtml -t latex > $ftex";

    my $latex = $ftex.IO.slurp;

    shell "pandoc $ftex -t markdown > $fmd";
    shell "pandoc $ftex -t plain    > $fplain";

    my $plaintext = 
    $fplain.IO.slurp.subst(:g, /\[image\]/, "");

    $plaintext
}
