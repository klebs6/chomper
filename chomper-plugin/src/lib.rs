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
/// See `bevy_dynamic_plugin/src/loader.rs#dynamically_load_plugin`.
pub type CreateKlebsFixBabyRustPlugin = unsafe fn() -> *mut dyn KlebsFixBabyRustPlugin;

pub trait LoadKlebsFixBabyRustDynamicPlugin {

    fn load_klebs_fix_baby_rust_plugin(&self, path: &str);
}

/// A collection of Bevy app logic and
/// configuration.
///
/// Plugins configure an [`App`]. When an [`App`]
/// registers a plugin, the plugin's
/// [`Plugin::build`] function is run.
pub trait KlebsFixBabyRustPlugin: Any + Send + Sync + Debug {

    /// Configures the [`App`] to which this
    /// plugin is added.
    fn klebs_fix_baby_rust(&self, 
        config: &KlebsFixBabyRustConfig,
        file:   &SourceFile,
        range:  TextRange) -> TextEdit;

    /// Configures a name for the [`Plugin`] which
    /// is primarily used for debugging.
    fn name(&self) -> &str {
        std::any::type_name::<Self>()
    }
}

/// Dynamically links a plugin a the given path. 
///
/// The plugin must export the
/// [CreateKlebsFixBabyRustPlugin] function.
pub fn dynamically_load_klebs_fix_baby_rust_plugin(path: &str) 
-> (Library, Box<dyn KlebsFixBabyRustPlugin>) {

    let lib = unsafe { Library::new(path).unwrap() };

    unsafe {

        let func: Symbol<CreateKlebsFixBabyRustPlugin> = lib.get(b"_create_klebs_fix_baby_rust_plugin").unwrap();

        let plugin = Box::from_raw(func());

        (lib, plugin)
    }
}
