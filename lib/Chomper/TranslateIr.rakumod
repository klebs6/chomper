use Chomper::TranslateIo;
use Chomper::TranslatePython;
use Chomper::TranslateCpp;

our sub translate-cpp-to-rust($ir) {
    translate-ir(
        $ir, 
        TranslationSource::<LangCpp>, 
        TranslationTarget::<LangRust>)
}

our sub translate-ir(
    $ir, 
    TranslationSource $src,
    TranslationTarget $dst)
{
    debug "will translate from $src to $dst";

    my @rust-snippets = gather given ($src,$dst) {
        when (TranslationSource::<LangCpp>,TranslationTarget::<LangRust>) {
            for $ir.List {
                take translate-cpp-ir-to-rust($_.WHAT.^name, $_);
            }
        }
        when (TranslationSource::<LangPython>,TranslationTarget::<LangRust>) {
            for $ir.List {
                take translate-python-ir-to-rust($_.WHAT.^name, $_);
            }
        }
        default {
            die "unsupported translation pathway!"
        }
    };

    say "----------------[translation]";
    for @rust-snippets {
        say "{$_}\n";
    }
}
