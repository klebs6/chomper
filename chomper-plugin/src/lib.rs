#![feature(arc_unwrap_or_clone)]

use std::any::Any;
use std::sync::Arc;
use std::fmt::Debug;

use base_db::FileRange;
use ide_db::RootDatabase;

use text_edit::TextEdit;

#[derive(Debug)]
pub struct KlebsPluginEnv {

    /* TODO: breaks on plugin side
    #[allow(dead_code)]
    pub semantics: &'db Semantics<'db, RootDatabase>,
    */

    //#[allow(dead_code)] pub type_inference: Arc<InferenceResult>,
    
    /*
    pub frange: FileRange,
    pub db:     &RootDatabase,
    */
}

#[derive(Debug)]
pub struct KlebsFixBabyRustConfig {

}

/// A type representing an unsafe function that
/// returns a mutable pointer to a [`Plugin`].
///
/// It is used for dynamically loading plugins.
///
pub type CreateKlebsFixBabyRustPlugin 
= unsafe fn() -> *mut dyn KlebsFixBabyRustPlugin;

pub trait KlebsFixBabyRustPlugin: Any + Send + Sync + Debug {

    fn klebs_fix_baby_rust(&self, 
        db:             &RootDatabase, 
        type_inference: Arc<hir_ty::InferenceResult>, 
        frange:         FileRange) -> TextEdit;

    fn name(&self) -> &str {
        std::any::type_name::<Self>()
    }
}

pub fn run_type_inference(db: &RootDatabase, frange: FileRange) -> Option<Arc<hir_ty::InferenceResult>> {

    use syntax::{ast,AstNode,ast::HasName};

    use hir_ty::db::HirDatabase;

    let semantics = hir::Semantics::new(db);

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

            match maybe_type_inference {
                Some(type_inference) => {
                    Some(type_inference)
                }
                None => {
                    None
                }
            }
        }
        None => {
            tracing::error!("no fn_ancestor! cannot do type inference!");
            None
        }
    }
}
