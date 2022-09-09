crate::ix!();

pub fn maybe_fix_errors_in_range_expr(
    db:   &RootDatabase, 
    expr: &ast::RangeExpr) -> Option<ast::Expr> {
    None
}
