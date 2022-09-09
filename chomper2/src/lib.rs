#![allow(dead_code)]
#![allow(unused_variables)]

#![feature(io_read_to_string)]

#[macro_use] mod imports; use imports::*;

x!{plugin}
x!{setup_logging}
x!{fix_statement}
x!{adjust_range}

x!{fix_array_expr}
x!{fix_await_expr}
x!{fix_bin_expr}
x!{fix_block_expr}
x!{fix_box_expr}
x!{fix_break_expr}
x!{fix_call_expr}
x!{fix_cast_expr}
x!{fix_closure_expr}
x!{fix_continue_expr}
x!{fix_field_expr}
x!{fix_for_expr}
x!{fix_if_expr}
x!{fix_index_expr}
x!{fix_literal_expr}
x!{fix_loop_expr}
x!{fix_macro_expr}
x!{fix_macro_stmts}
x!{fix_match_expr}
x!{fix_method_call_expr}
x!{fix_paren_expr}
x!{fix_path_expr}
x!{fix_prefix_expr}
x!{fix_range_expr}
x!{fix_record_expr}
x!{fix_ref_expr}
x!{fix_return_expr}
x!{fix_try_expr}
x!{fix_tuple_expr}
x!{fix_while_expr}
x!{fix_yield_expr}
x!{fix_let_expr}
x!{fix_underscore_expr}

#[no_mangle]
#[allow(improper_ctypes_definitions)]
pub extern "C" fn create_klebs_fix_baby_rust_plugin() -> *mut dyn KlebsFixBabyRustPlugin {

    let b = Box::new(KlebsFix::default());

    Box::<KlebsFix>::into_raw(b)
}

#[derive(Default,Debug)]
pub struct KlebsFix {

}

impl KlebsFixBabyRustPlugin for KlebsFix {

    // Feature: Klebs Fix Baby Rust
    //
    // chomper integrations!
    //
    fn klebs_fix_baby_rust(
        &self,
        db:     &RootDatabase,
        config: &KlebsFixBabyRustConfig,
        file: &SourceFile,
        range: TextRange,
    ) -> TextEdit {
        klebs_fix_baby_rust(db,config,file,range)
    }
}
