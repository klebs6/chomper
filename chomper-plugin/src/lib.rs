use std::any::Any;
use std::fmt::Debug;

use libloading::{Library, Symbol};

use syntax::{
    NodeOrToken,
    TextSize,
    AstNode,
    SourceFile,
    TextRange
};

use text_edit::TextEdit;

#[derive(Debug)]
pub struct KlebsFixBabyRustConfig {

}

/// A type representing an unsafe function that
/// returns a mutable pointer to a [`Plugin`].
///
/// It is used for dynamically loading plugins.
///
pub type CreateKlebsFixBabyRustPlugin = unsafe fn() -> *mut dyn KlebsFixBabyRustPlugin;

pub trait LoadKlebsFixBabyRustDynamicPlugin {

    fn load_klebs_fix_baby_rust_plugin(&self, path: &str);
}

pub trait KlebsFixBabyRustPlugin: Any + Send + Sync + Debug {

    fn klebs_fix_baby_rust(&self, 
        config: &KlebsFixBabyRustConfig,
        file:   &SourceFile,
        range:  TextRange) -> TextEdit;

    fn name(&self) -> &str {
        std::any::type_name::<Self>()
    }
}

/// Dynamically links a plugin a the given path. 
///
/// The plugin must export the
/// [CreateKlebsFixBabyRustPlugin] function.
#[tracing::instrument]
pub fn dynamically_load_klebs_fix_baby_rust_plugin(path: &str) 
-> Result<(Library, Box<dyn KlebsFixBabyRustPlugin>), String> {

    let lib = unsafe { Library::new(path).unwrap() };

    tracing::debug!("created lib: {:#?}", lib);

    unsafe {

        let symname = b"create_klebs_fix_baby_rust_plugin";

        match lib.get(symname) {
            Ok(symbol) => {
                let func: Symbol<CreateKlebsFixBabyRustPlugin> = symbol;

                let plugin = Box::from_raw(func());

                tracing::debug!("created plugin: {:#?}", plugin);

                Ok((lib, plugin))
            },
            Err(e) => {

                Err(
                    format!("error while getting {} from {}: {}", 
                        String::from_utf8(symname.to_vec()).unwrap(), 
                        path,
                        e, 
                    )
                )
            }
        }
    }
}
