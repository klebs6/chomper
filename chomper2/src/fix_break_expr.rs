crate::ix!();

pub fn maybe_fix_errors_in_break_expr(
    db:   &RootDatabase, 
    expr: &ast::BreakExpr) -> Option<ast::Expr> {
    None
}
