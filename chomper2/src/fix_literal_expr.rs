crate::ix!();

pub fn maybe_fix_errors_in_literal_expr(
    db:   &RootDatabase, 
    expr: &ast::Literal) -> Option<ast::Expr> {
    None
}
