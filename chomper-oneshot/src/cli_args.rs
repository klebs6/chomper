crate::ix!();

/// takes the translated cpp -> rust text from
/// raku and runs it through some rust-analyzer
/// code
#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
pub struct Args {

    #[clap(short, long, value_parser, default_value_t = EXAMPLE_TEXT.to_string())]
    pub text: String,

    #[clap(short, long, value_parser)]
    pub file: Option<String>,

    #[clap(long, value_parser, default_value_t = 0)]
    pub first: u16,

    #[clap(long, value_parser, default_value_t = 0)]
    pub last: u16,
}
