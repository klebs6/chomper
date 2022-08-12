#[macro_use] mod imports; use imports::*;

x!{util}
x!{plugin}
x!{setup_logging}

#[no_mangle]
pub extern "C" fn create_klebs_fix_baby_rust_plugin() -> *mut dyn KlebsFixBabyRustPlugin {

    write_stupid_file("/tmp/foo-did-this-hit", Some("yes-6"));

    let mut b = Box::new(KlebsFix::default());

    Box::<KlebsFix>::into_raw(b)
}
