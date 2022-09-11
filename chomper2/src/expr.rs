crate::ix!();

pub fn maybe_fix_errors_in_expr(
    db:   &RASnapshot, 
    expr: &ast::Expr) -> Option<ast::Expr> {

    tracing::info!("expr: {:?}", expr);

    match expr {
        ast::Expr::ArrayExpr(x)      => maybe_fix_errors_in_array_expr(db,&x),
        ast::Expr::AwaitExpr(x)      => maybe_fix_errors_in_await_expr(db,&x),
        ast::Expr::BinExpr(x)        => maybe_fix_errors_in_bin_expr(db,&x),
        ast::Expr::BlockExpr(x)      => maybe_fix_errors_in_block_expr(db,&x),
        ast::Expr::BoxExpr(x)        => maybe_fix_errors_in_box_expr(db,&x),
        ast::Expr::BreakExpr(x)      => maybe_fix_errors_in_break_expr(db,&x),
        ast::Expr::CallExpr(x)       => maybe_fix_errors_in_call_expr(db,&x),
        ast::Expr::CastExpr(x)       => maybe_fix_errors_in_cast_expr(db,&x),
        ast::Expr::ClosureExpr(x)    => maybe_fix_errors_in_closure_expr(db,&x),
        ast::Expr::ContinueExpr(x)   => maybe_fix_errors_in_continue_expr(db,&x),
        ast::Expr::FieldExpr(x)      => maybe_fix_errors_in_field_expr(db,&x),
        ast::Expr::ForExpr(x)        => maybe_fix_errors_in_for_expr(db,&x),
        ast::Expr::IfExpr(x)         => maybe_fix_errors_in_if_expr(db,&x),
        ast::Expr::IndexExpr(x)      => maybe_fix_errors_in_index_expr(db,&x),
        ast::Expr::Literal(x)        => maybe_fix_errors_in_literal_expr(db,&x),
        ast::Expr::LoopExpr(x)       => maybe_fix_errors_in_loop_expr(db,&x),
        ast::Expr::MacroExpr(x)      => maybe_fix_errors_in_macro_expr(db,&x),
        ast::Expr::MacroStmts(x)     => maybe_fix_errors_in_macro_stmts(db,&x),
        ast::Expr::MatchExpr(x)      => maybe_fix_errors_in_match_expr(db,&x),
        ast::Expr::MethodCallExpr(x) => maybe_fix_errors_in_method_call_expr(db,&x),
        ast::Expr::ParenExpr(x)      => maybe_fix_errors_in_paren_expr(db,&x),
        ast::Expr::PathExpr(x)       => maybe_fix_errors_in_path_expr(db,&x),
        ast::Expr::PrefixExpr(x)     => maybe_fix_errors_in_prefix_expr(db,&x),
        ast::Expr::RangeExpr(x)      => maybe_fix_errors_in_range_expr(db,&x),
        ast::Expr::RecordExpr(x)     => maybe_fix_errors_in_record_expr(db,&x),
        ast::Expr::RefExpr(x)        => maybe_fix_errors_in_ref_expr(db,&x),
        ast::Expr::ReturnExpr(x)     => maybe_fix_errors_in_return_expr(db,&x),
        ast::Expr::TryExpr(x)        => maybe_fix_errors_in_try_expr(db,&x),
        ast::Expr::TupleExpr(x)      => maybe_fix_errors_in_tuple_expr(db,&x),
        ast::Expr::WhileExpr(x)      => maybe_fix_errors_in_while_expr(db,&x),
        ast::Expr::YieldExpr(x)      => maybe_fix_errors_in_yield_expr(db,&x),
        ast::Expr::LetExpr(x)        => maybe_fix_errors_in_let_expr(db,&x),
        ast::Expr::UnderscoreExpr(x) => maybe_fix_errors_in_underscore_expr(db,&x),
    }
}
