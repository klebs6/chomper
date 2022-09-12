crate::ix!();

//#[tracing::instrument(level = "info")]
pub fn maybe_fix_errors_in_bin_expr(
    world: &KlebsPluginEnv, 
    expr:  &ast::BinExpr) -> Option<ast::Expr> {

    let syntax   = expr.syntax();
    let children = syntax.children();

    let (lhs, rhs) = expr.sub_exprs();

    tracing::info!("lhs: {:?}", lhs);
    tracing::info!("rhs: {:?}", rhs);
    tracing::info!("op: {:?}",  expr.op_token());

    if let Some(op_token) = expr.op_token() {
        match op_token.kind() {
            parser::SyntaxKind::LTEQ => {
                None
            },
            parser::SyntaxKind::GTEQ => {
                None
            },
            parser::SyntaxKind::PLUSEQ => {
                None
            },
            parser::SyntaxKind::MINUSEQ => {
                None
            },
            parser::SyntaxKind::PIPEEQ => {
                maybe_fix_oreq_expr(
                    world,
                    &lhs.unwrap(),
                    &rhs.unwrap()
                )
            },
            parser::SyntaxKind::AMPEQ => {
                None
            },
            parser::SyntaxKind::CARETEQ => {
                None
            },
            parser::SyntaxKind::SLASHEQ => {
                None
            },
            parser::SyntaxKind::STAREQ => {
                None
            },
            parser::SyntaxKind::PERCENTEQ => {
                None
            },
            parser::SyntaxKind::AMP2 => {
                None
            },
            parser::SyntaxKind::PIPE2 => {
                None
            },
            parser::SyntaxKind::SHL => {
                None
            },
            parser::SyntaxKind::SHR => {
                None
            },
            parser::SyntaxKind::SHLEQ => {
                None
            },
            parser::SyntaxKind::SHREQ => {
                None
            },
            _ => {
                tracing::warn!("unimplemented");
                None
            }
        }

    } else {
        None
    }
}
