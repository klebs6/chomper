crate::ix!();

#[tracing::instrument(level = "info")]
pub fn maybe_fix_errors_in_statement(
    db:   &RootDatabase, 
    stmt: &ast::Stmt) -> Option<ast::Expr> {

    match stmt {
        ast::Stmt::ExprStmt(expr_stmt) => {
            maybe_fix_errors_in_expr_statement(db, &expr_stmt)
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

pub fn maybe_fix_errors_in_expr_statement(
    db:        &RootDatabase, 
    expr_stmt: &ast::ExprStmt) -> Option<ast::Expr> {

    let expr = expr_stmt.expr();

    tracing::info!("expr: {:?}", expr);

    let maybe_fixed_expr = match expr {
        Some(ast::Expr::ArrayExpr(x))      => maybe_fix_errors_in_array_expr(db,&x),
        Some(ast::Expr::AwaitExpr(x))      => maybe_fix_errors_in_await_expr(db,&x),
        Some(ast::Expr::BinExpr(x))        => maybe_fix_errors_in_bin_expr(db,&x),
        Some(ast::Expr::BlockExpr(x))      => maybe_fix_errors_in_block_expr(db,&x),
        Some(ast::Expr::BoxExpr(x))        => maybe_fix_errors_in_box_expr(db,&x),
        Some(ast::Expr::BreakExpr(x))      => maybe_fix_errors_in_break_expr(db,&x),
        Some(ast::Expr::CallExpr(x))       => maybe_fix_errors_in_call_expr(db,&x),
        Some(ast::Expr::CastExpr(x))       => maybe_fix_errors_in_cast_expr(db,&x),
        Some(ast::Expr::ClosureExpr(x))    => maybe_fix_errors_in_closure_expr(db,&x),
        Some(ast::Expr::ContinueExpr(x))   => maybe_fix_errors_in_continue_expr(db,&x),
        Some(ast::Expr::FieldExpr(x))      => maybe_fix_errors_in_field_expr(db,&x),
        Some(ast::Expr::ForExpr(x))        => maybe_fix_errors_in_for_expr(db,&x),
        Some(ast::Expr::IfExpr(x))         => maybe_fix_errors_in_if_expr(db,&x),
        Some(ast::Expr::IndexExpr(x))      => maybe_fix_errors_in_index_expr(db,&x),
        Some(ast::Expr::Literal(x))        => maybe_fix_errors_in_literal_expr(db,&x),
        Some(ast::Expr::LoopExpr(x))       => maybe_fix_errors_in_loop_expr(db,&x),
        Some(ast::Expr::MacroExpr(x))      => maybe_fix_errors_in_macro_expr(db,&x),
        Some(ast::Expr::MacroStmts(x))     => maybe_fix_errors_in_macro_stmts(db,&x),
        Some(ast::Expr::MatchExpr(x))      => maybe_fix_errors_in_match_expr(db,&x),
        Some(ast::Expr::MethodCallExpr(x)) => maybe_fix_errors_in_method_call_expr(db,&x),
        Some(ast::Expr::ParenExpr(x))      => maybe_fix_errors_in_paren_expr(db,&x),
        Some(ast::Expr::PathExpr(x))       => maybe_fix_errors_in_path_expr(db,&x),
        Some(ast::Expr::PrefixExpr(x))     => maybe_fix_errors_in_prefix_expr(db,&x),
        Some(ast::Expr::RangeExpr(x))      => maybe_fix_errors_in_range_expr(db,&x),
        Some(ast::Expr::RecordExpr(x))     => maybe_fix_errors_in_record_expr(db,&x),
        Some(ast::Expr::RefExpr(x))        => maybe_fix_errors_in_ref_expr(db,&x),
        Some(ast::Expr::ReturnExpr(x))     => maybe_fix_errors_in_return_expr(db,&x),
        Some(ast::Expr::TryExpr(x))        => maybe_fix_errors_in_try_expr(db,&x),
        Some(ast::Expr::TupleExpr(x))      => maybe_fix_errors_in_tuple_expr(db,&x),
        Some(ast::Expr::WhileExpr(x))      => maybe_fix_errors_in_while_expr(db,&x),
        Some(ast::Expr::YieldExpr(x))      => maybe_fix_errors_in_yield_expr(db,&x),
        Some(ast::Expr::LetExpr(x))        => maybe_fix_errors_in_let_expr(db,&x),
        Some(ast::Expr::UnderscoreExpr(x)) => maybe_fix_errors_in_underscore_expr(db,&x),
        None => {
            tracing::warn!("no expression");
            None
        }
    };

    None
}
