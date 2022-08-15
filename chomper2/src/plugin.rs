crate::ix!();

#[derive(Default,Debug)]
pub struct KlebsFix {

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

        write_stupid_file("/tmp/chomper2-entrypoint-count", None);

        tracing::info!("klebs_fix_baby_rust");
        tracing::info!("range:  {:?}", range);
        tracing::info!("config: {:?}", config);
        tracing::info!("file:   {:?}", file);

        let range = if range.is_empty() {

            tracing::info!("range.is_empty() is true");

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

        tracing::info!("range:  {:?}", range);

        let syntax = file.syntax();
        let text   = syntax.text().slice(range.start()..range.end());

        tracing::info!("syntax: {:?}", syntax);
        tracing::info!("text:   {:?}",   text);

        let edit = TextEdit::builder();

        let elem = file.syntax().covering_element(range);

        tracing::info!("elem: {:?}", elem);

        match elem {
            NodeOrToken::Node(node) => {
                tracing::info!("-node-");
                for _token in node.descendants_with_tokens().filter_map(|it| it.into_token()) {
                    //tracing::info!("token: {:?}", token);
                }
            }
            NodeOrToken::Token(token) => {
                tracing::info!("token: {:?}", token);
            },
        };

        edit.finish()
    }
}
