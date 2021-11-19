our $whitelist-file = 
"/Users/kleb/bethesda/work/repo/translator/txt/whitelist.txt";

our $text-typemap-file =
"/Users/kleb/bethesda/work/repo/translator/txt/text-typemap.txt";

our $snake-case-file = 
"/Users/kleb/bethesda/work/repo/translator/txt/snake-cased.txt";

our sub whitelist($type) {
    spurt $whitelist-file, "$type\n", :append;
}

our sub text-typemap($t1, $t2) {
    spurt $text-typemap-file, "$t1 $t2\n", :append;
}

our sub update-snake-case-file(:$input, :$output) {
    spurt $snake-case-file, "$input $output\n" , :append;
}

our sub maybe-update-snake-case-file(:$input, :$output) {
    if $input.trim ne $output.trim {
        update-snake-case-file(:$input,:$output);
    }
}

our sub sort-uniq-snake-case-file {
    my @uniq = qqx/sort $snake-case-file | uniq/;
    spurt $snake-case-file, "{@uniq.join('')}\n";
}

