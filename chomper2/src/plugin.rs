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

pub fn test() {

    /*
    tracing::info!("why no work?");

    let edit = TextEdit::builder();

    let semantics = Semantics::new(db);

    let file: SourceFile = semantics.parse(frange.file_id);

    match maybe_adjust_range(&file,frange.range) {
        Some(range) => {

            let elem = file.syntax().covering_element(frange.range.clone());

            tracing::info!("got a elem: {:?}", elem);

            let maybe_fn_ancestor = match elem {
                NodeOrToken::Node(node)   => node.ancestors().find_map(ast::Fn::cast),
                NodeOrToken::Token(token) => token.parent_ancestors().find_map(ast::Fn::cast),
            };

            match maybe_fn_ancestor {
                Some(ref fn_ancestor) => {

                    tracing::info!("about to run the thing which breaks");

                    let maybe_type_inference = match semantics.to_def(fn_ancestor) {

                        Some(def) => {

                            tracing::info!("success! received: def: {:?}", def);

                            let id               = FunctionId::from(def);
                            let dbid             = DefWithBodyId::FunctionId(id);
                            let inference_result = db.infer_query(dbid);

                            Some(inference_result)
                        }

                        None => {
                            None
                        }
                    };

                    tracing::info!("type_inference: {:?}", maybe_type_inference);
                }
                None => {
                    tracing::error!("no fn_ancestor! cannot do type inference!");
                }
            }

            tracing::info!("maybe_fn_ancestor: {:?}", maybe_fn_ancestor);
        }

        None => {
            tracing::error!("probably invalid range: {:?}", frange);
        }
    }

    edit.finish()
    */
}

/*
pub fn xxx_breaks_on_plugin_side_works_on_host_side(db: &RootDatabase, frange: FileRange) {

    use syntax::{ast,AstNode,ast::HasName};

    use hir_ty::db::HirDatabase;

    let semantics = ide::Semantics::new(db);

    let file: ast::SourceFile = semantics.parse(frange.file_id);

    let elem = file.syntax().covering_element(frange.range.clone());

    tracing::info!("got a elem: {:?}", elem);

    let maybe_fn_ancestor = match elem {
        syntax::NodeOrToken::Node(node)   => node.ancestors().find_map(ast::Fn::cast),
        syntax::NodeOrToken::Token(token) => token.parent_ancestors().find_map(ast::Fn::cast),
    };

    match maybe_fn_ancestor {

        Some(ref fn_ancestor) => {

            tracing::info!("got a fn_ancestor: {:?}", fn_ancestor.name().unwrap().syntax().text());
            tracing::info!("about to run the thing which breaks");

            let maybe_type_inference = match semantics.to_def(fn_ancestor) {

                Some(def) => {

                    tracing::info!("success! received: def: {:?}", def);

                    let id               = hir_def::FunctionId::from(def);
                    let dbid             = hir_def::DefWithBodyId::FunctionId(id);
                    let inference_result = db.infer_query(dbid);

                    Some(inference_result)
                }

                None => {
                    None
                }
            };

            tracing::info!("type_inference: {:?}", maybe_type_inference);
        }

        None => {
            tracing::error!("no fn_ancestor! cannot do type inference!");
        }
    }

    tracing::info!("maybe_fn_ancestor: {:?}", maybe_fn_ancestor);
}
*/

pub fn klebs_fix_baby_rust(db: &RootDatabase, inference_result: Arc<hir_ty::InferenceResult>, frange: FileRange) -> TextEdit 
{
    let edit = TextEdit::builder();

    tracing::info!("plugin side");
    tracing::info!("file_range: {:?}",frange);
    tracing::info!("type_inference: {:?}", inference_result);

    edit.finish()

    /*

    tracing::info!("world: {:#?}", world.type_inferences);

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
                    maybe_fix_errors_in_statement(world,&stmt);

                    tracing::info!("maybe_fixed_stmt: {:?}", maybe_fixed_stmt);

                    //once we know it works, can
                    //apply it to the edit
                }

            } else if let Some(expr_stmt) = ast::ExprStmt::cast(node.clone()) {

                let maybe_fixed_expr_stmt = 
                maybe_fix_errors_in_expr_stmt(world,&expr_stmt);

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
    */
}
