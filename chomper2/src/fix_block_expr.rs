crate::ix!();

pub fn maybe_fix_errors_in_block_expr(
    db:   &RootDatabase, 
    expr: &ast::BlockExpr) -> Option<ast::Expr> {
    None
}
