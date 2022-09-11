crate::ix!();

#[tracing::instrument(level = "info")]
pub fn maybe_fix_errors_in_statement(
    db:   &RASnapshot, 
    stmt: &ast::Stmt) -> Option<ast::Expr> {

    match stmt {
        ast::Stmt::ExprStmt(expr_stmt) => {
            maybe_fix_errors_in_expr_stmt(db, &expr_stmt)
        }
        ast::Stmt::Item(item) => {
            tracing::warn!("item: {:?}", item);
            None
        }
        ast::Stmt::LetStmt(let_stmt) => {
            tracing::warn!("let_stmt: {:?}", let_stmt);
            None
        }
    }
}

pub fn maybe_fix_errors_in_expr_stmt(
    db:        &RASnapshot, 
    expr_stmt: &ast::ExprStmt) -> Option<ast::Expr> {

    if let Some(expr) = expr_stmt.expr() {
        maybe_fix_errors_in_expr(db,&expr)
    } else {
        None
    }
}
