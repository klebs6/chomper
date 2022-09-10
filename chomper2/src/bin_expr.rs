crate::ix!();

//#[tracing::instrument(level = "info")]
pub fn maybe_fix_errors_in_bin_expr(
    db:   &RootDatabase, 
    expr: &ast::BinExpr) -> Option<ast::Expr> {

    let syntax   = expr.syntax();
    let children = syntax.children();

    tracing::info!("lhs: {:?}", expr.lhs());
    tracing::info!("rhs: {:?}", expr.rhs());
    tracing::info!("op: {:?}",  expr.op_token());

    if let Some(op_token) = expr.op_token() {
        match op_token.kind() {
            parser::SyntaxKind::LTEQ => {

            },
            parser::SyntaxKind::GTEQ => {

            },
            parser::SyntaxKind::PLUSEQ => {

            },
            parser::SyntaxKind::MINUSEQ => {

            },
            parser::SyntaxKind::PIPEEQ => {
                tracing::info!("or equals!");
            },
            parser::SyntaxKind::AMPEQ => {

            },
            parser::SyntaxKind::CARETEQ => {

            },
            parser::SyntaxKind::SLASHEQ => {

            },
            parser::SyntaxKind::STAREQ => {

            },
            parser::SyntaxKind::PERCENTEQ => {

            },
            parser::SyntaxKind::AMP2 => {

            },
            parser::SyntaxKind::PIPE2 => {

            },
            parser::SyntaxKind::SHL => {

            },
            parser::SyntaxKind::SHR => {

            },
            parser::SyntaxKind::SHLEQ => {

            },
            parser::SyntaxKind::SHREQ => {

            },
            _ => { }
        }
    }

    None
}
