crate::ix!();

pub fn maybe_fix_errors_in_field_expr(
    db:   &RootDatabase, 
    expr: &ast::FieldExpr) -> Option<ast::Expr> {
    None
}
