#![feature(io_read_to_string)]

#[macro_use] mod imports; use imports::*;

x!{plugin}
x!{setup_logging}

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
        config: &KlebsFixBabyRustConfig,
        file: &SourceFile,
        range: TextRange,
    ) -> TextEdit {
        klebs_fix_baby_rust(config,file,range)
    }
}
