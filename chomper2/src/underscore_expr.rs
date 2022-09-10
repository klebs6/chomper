crate::ix!();

#[tracing::instrument(level = "info")]
pub fn maybe_fix_errors_in_underscore_expr(
    db:   &RootDatabase, 
    expr: &ast::UnderscoreExpr) -> Option<ast::Expr> {
    tracing::warn!("unimplemented");
    None
}
