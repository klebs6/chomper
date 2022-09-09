crate::ix!();

pub fn maybe_fix_errors_in_bin_expr(
    db:   &RootDatabase, 
    expr: &ast::BinExpr) -> Option<ast::Expr> {
    None
}
