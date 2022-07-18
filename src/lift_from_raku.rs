use clap::Parser;

pub const EXAMPLE_TEXT: &'static str = r#"
for source_i in 0..NUM_SOURCES {
    addrman.add(g_addresses[source_i], g_sources[source_i]);
}
"#;

/// takes the translated cpp -> rust text from
/// raku and runs it through some rust-analyzer
/// code
#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
struct Args {

    #[clap(short, long, value_parser, default_value_t = EXAMPLE_TEXT.to_string())]
    text: String,
}

fn main() {

    let text = Args::parse().text;

    println!("{}", text);
}
