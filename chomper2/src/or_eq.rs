crate::ix!();

pub fn maybe_fix_oreq_expr(
    world: &KlebsPluginEnv, 
    lhs:   &ast::Expr,
    rhs:   &ast::Expr) -> Option<ast::Expr> {

    tracing::info!("fix oreq what in the fucking fuck!?");

    tracing::info!("inference: {:#?}", world.type_inference);

    let lhs_fixed = maybe_fix_errors_in_expr(world, lhs);
    let rhs_fixed = maybe_fix_errors_in_expr(world, rhs);

    /*
    let semantics = world.semantics;

    tracing::info!("semantics: {:#?}", semantics);

    if let Some(func_def) = rhs.syntax().ancestors().find_map(ast::Fn::cast) {

        if let Some(name) = func_def.name() {

            tracing::info!("func_def: {:?}", name.syntax().text());

        } else {

            tracing::warn!("couldn't get func_def.name()");
        }

        tracing::info!("got here");

        let maybe_def = semantics.to_def(&func_def);

        tracing::info!("maybe_def {:?}",maybe_def);

        tracing::warn!("why?");

        /*
        if let Some(def) = semantics.to_def(&func_def) {

            tracing::info!("def: {:?}", def);

            let id  = FunctionId::from(def);

            tracing::info!("id: {:?}", id);

            let infer = db.infer(DefWithBodyId::from(id));

            tracing::info!("infer: {:?}", infer);

        } else {

            tracing::info!("couldn't get def");
        }
        */

    } else {

        tracing::warn!("couldn't get func_def");
    }
    */

    None
}
