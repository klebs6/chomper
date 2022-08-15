#![feature(io_read_to_string)]

#[macro_use] mod imports; use imports::*;

x!{util}
x!{plugin}
x!{setup_logging}

#[no_mangle]
#[allow(improper_ctypes_definitions)]
pub extern "C" fn create_klebs_fix_baby_rust_plugin() -> *mut dyn KlebsFixBabyRustPlugin {

    write_stupid_file("/tmp/chomper2-create-klebs-fix-baby-rust-plugin-count", None);
    write_stupid_file("/tmp/chomper2-create-klebs-fix-baby-rust-plugin-count-fuck", None);

    let b = Box::new(KlebsFix::default());

    Box::<KlebsFix>::into_raw(b)
}
