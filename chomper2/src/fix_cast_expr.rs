crate::ix!();

pub fn maybe_fix_errors_in_cast_expr(
    db:   &RootDatabase, 
    expr: &ast::CastExpr) -> Option<ast::Expr> {
    None
}
