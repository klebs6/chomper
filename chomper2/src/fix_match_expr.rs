crate::ix!();

pub fn maybe_fix_errors_in_match_expr(
    db:   &RootDatabase, 
    expr: &ast::MatchExpr) -> Option<ast::Expr> {
    None
}
