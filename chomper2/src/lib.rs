use ide::*;

use syntax::{
    NodeOrToken,
    TextSize,
    AstNode,
    SourceFile,
    TextRange
};

use text_edit::TextEdit;
use chomper_plugin::*;

#[derive(Default)]
struct KlebsFix {

}

impl KlebsFixBabyRustPlugin for KlebsFix {

    // Feature: Klebs Fix Baby Rust
    //
    // chomper integrations!
    //
    fn klebs_fix_baby_rust(
        config: &KlebsFixBabyRustConfig,
        file: &SourceFile,
        range: TextRange,
    ) -> TextEdit {

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

pub fn create_klebs_fix_baby_rust_plugin() -> *mut dyn KlebsFidBabyRustPlugin {
    Box::new(KlebsFix::default()).into_raw()
}
