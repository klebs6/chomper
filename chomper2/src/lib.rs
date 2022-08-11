use ide::*;

use syntax::{
    NodeOrToken,
    TextSize,
    AstNode,
    SourceFile,
    TextRange
};

use chomper_plugin::*;
use text_edit::TextEdit;
use ctor::ctor;

use tracing_log::LogTracer;
use log;

use tracing::{info, Level};
use tracing_subscriber::FmtSubscriber;
use tracing_subscriber::fmt::writer::{BoxMakeWriter,MakeWriter};
use std::sync::Arc;
use std::path::Path;
use std::io;
use std::fs::File;
use lazy_static::lazy_static;

#[derive(Debug)]
struct KlebsFix {

}

impl Default for KlebsFix {

    fn default() -> Self {

        Self { 

        }
    }
}

fn write_stupid_file(file: &str, data: Option<&str>) {

    let msg = match data {
        Some(data) => data.to_string(),
        None => {
            let val: i32 = match std::fs::read_to_string(file) {
                Ok(s) => {
                    match s.parse() {
                        Ok(parsed) => parsed,
                        Err(_)     => 0,
                    }
                },
                Err(_) => 0,
            };

            format!{"{}",val + 1}
        }
    };

    std::fs::write(file, msg).expect("Unable to write file");
}

impl KlebsFixBabyRustPlugin for KlebsFix {

    // Feature: Klebs Fix Baby Rust
    //
    // chomper integrations!
    //
    fn klebs_fix_baby_rust(
        &self,
        config: &KlebsFixBabyRustConfig,
        file: &SourceFile,
        range: TextRange,
    ) -> TextEdit {

        write_stupid_file("/tmp/foo", None);

        tracing::debug!("klebs_fix_baby_rust");
        tracing::debug!("config: {:?}", config);
        tracing::debug!("range:  {:?}", range);
        tracing::debug!("file:   {:?}", file);
        tracing::debug!("yess!!!");

        let range = if range.is_empty() {

            tracing::debug!("range.is_empty() is true");

            let syntax = file.syntax();
            let text   = syntax.text().slice(range.start()..);

            let pos = match text.find_char('\n') {
                None => return TextEdit::builder().finish(),
                Some(pos) => pos,
            };

            TextRange::at(range.start(), pos)

        } else {
            range
        };

        tracing::debug!("range:  {:?}", range);

        let syntax = file.syntax();
        let text   = syntax.text().slice(range.start()..range.end());

        tracing::debug!("syntax: {:?}", syntax);
        tracing::debug!("text:   {:?}",   text);

        let mut edit = TextEdit::builder();

        match file.syntax().covering_element(range) {
            NodeOrToken::Node(node) => {
                for token in node.descendants_with_tokens().filter_map(|it| it.into_token()) {
                    /*
                    remove_newlines(config, &mut edit, &token, range)
                    */
                }
            }
            NodeOrToken::Token(token) => {
                /*
                remove_newlines(config, &mut edit, &token, range)
                */
            },
        };

        edit.finish()
    }
}

#[ctor] fn setup_logging() {

    let logpath = std::env::var("RA_PLUGIN_LOG_FILE").ok();
    let logflag = std::env::var("RA_PLUGIN_LOG").ok();

    let msg = format!{
        "in function setup_logging with RA_PLUGIN_LOG_FILE={} and RA_PLUGIN_LOG={}",
        logpath.as_ref().unwrap(),
        logflag.as_ref().unwrap(),
    };

    write_stupid_file("/tmp/foo-setup-logging", Some(msg.as_str()));

    let file = match logpath {
        Some(p) => match File::create(p) {
            Ok(f)  => Some(f),
            Err(e) => None,
        },
        None    => None,
    };

    write_stupid_file("/tmp/foo-check-file", Some(format!("{:#?}", file).as_str()));

    let writer = match file {
        Some(file) => BoxMakeWriter::new(Arc::new(file)),
        None       => BoxMakeWriter::new(io::stderr),
    };

    // a builder for `FmtSubscriber`.
    let subscriber = FmtSubscriber::builder()
        // all spans/events with a level higher than TRACE (e.g, debug, info, warn, etc.)
        // will be written to stdout.
        .with_max_level(Level::TRACE)
        .with_env_filter(tracing_subscriber::EnvFilter::from_env("RA_PLUGIN_LOG"))
        .with_writer(writer)
        // completes the builder.
        .finish();

    tracing::subscriber::set_global_default(subscriber)
        .expect("setting default subscriber failed");

    tracing::info!("test trace info from chomper2!");
}

#[no_mangle]
pub extern "C" fn create_klebs_fix_baby_rust_plugin() -> *mut dyn KlebsFixBabyRustPlugin {

    let mut b = Box::new(KlebsFix::default());

    Box::<KlebsFix>::into_raw(b)
}
