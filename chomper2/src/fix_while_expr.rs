crate::ix!();

pub fn maybe_fix_errors_in_while_expr(
    db:   &RootDatabase, 
    expr: &ast::WhileExpr) -> Option<ast::Expr> {
    None
}
