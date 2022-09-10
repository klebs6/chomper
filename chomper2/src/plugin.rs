crate::ix!();

pub fn maybe_debug_header(config: &KlebsFixBabyRustConfig, file: &SourceFile, range: TextRange)
{
    const TRACE_FUNCTION_ARGS: bool = true;

    if TRACE_FUNCTION_ARGS {

        tracing::info!("klebs_fix_baby_rust");
        tracing::info!("range:  {:?}", range);
        tracing::info!("config: {:?}", config);
        tracing::info!("file:   {:?}", file);
    }
}

pub fn klebs_fix_baby_rust(
    db:     &RootDatabase,
    config: &KlebsFixBabyRustConfig,
    file: &SourceFile,
    range: TextRange,
) -> TextEdit 
{
    write_stupid_file("/tmp/chomper2-entrypoint-count", None);

    maybe_debug_header(config,file,range);

    let maybe_range = maybe_adjust_range(file,range);

    if maybe_range.is_none() {
        return TextEdit::builder().finish();
    }

    let range = maybe_range.unwrap();

    tracing::info!("range: {:?}", range);

    let syntax = file.syntax();
    let text   = syntax.text().slice(range.start()..range.end());

    tracing::info!("syntax: {:?}", syntax);
    tracing::info!("text:   {:?}",   text);

    let edit = TextEdit::builder();

    let elem = file.syntax().covering_element(range);

    tracing::info!("elem: {:?}",      elem);
    tracing::info!("elem_kind: {:?}", elem.kind());

    match elem {

        NodeOrToken::Node(node) => {

            tracing::info!("--node--");
            tracing::info!("{:?}", node);

            if let Some(stmt_list) = ast::StmtList::cast(node.clone()) {

                tracing::info!("got stmt_list");

                for stmt in stmt_list.statements() {

                    tracing::info!("wtf again?");

                    let maybe_fixed_stmt = 
                    maybe_fix_errors_in_statement(db,&stmt);

                    tracing::info!("maybe_fixed_stmt: {:?}", maybe_fixed_stmt);

                    //once we know it works, can
                    //apply it to the edit
                }

            } else if let Some(expr_stmt) = ast::ExprStmt::cast(node.clone()) {

                let maybe_fixed_expr_stmt = 
                maybe_fix_errors_in_expr_statement(db,&expr_stmt);

                tracing::info!("maybe_fixed_expr_stmt: {:?}", maybe_fixed_expr_stmt);

            } else {

                tracing::warn!("no stmt_list -- why?");
            }
        }

        NodeOrToken::Token(token) => {
            tracing::warn!("token: {:?}", token);
        },
    };

    edit.finish()
}
