#![allow(dead_code)]
#![allow(unused_variables)]

#![feature(io_read_to_string)]

#[macro_use] mod imports; use imports::*;

x!{plugin}
x!{setup_logging}
x!{statement}
x!{adjust_range}

x!{array_expr}
x!{await_expr}
x!{bin_expr}
x!{block_expr}
x!{box_expr}
x!{break_expr}
x!{call_expr}
x!{cast_expr}
x!{closure_expr}
x!{continue_expr}
x!{field_expr}
x!{for_expr}
x!{if_expr}
x!{index_expr}
x!{let_expr}
x!{literal_expr}
x!{loop_expr}
x!{macro_expr}
x!{macro_stmts}
x!{match_expr}
x!{method_call_expr}
x!{paren_expr}
x!{path_expr}
x!{prefix_expr}
x!{range_expr}
x!{record_expr}
x!{ref_expr}
x!{return_expr}
x!{try_expr}
x!{tuple_expr}
x!{underscore_expr}
x!{while_expr}
x!{yield_expr}

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
