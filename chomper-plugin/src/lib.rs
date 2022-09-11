use std::any::Any;
use std::fmt::Debug;

use syntax::{
    SourceFile,
    TextRange
};

use base_db::salsa;
use ide_db::RootDatabase;

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

pub trait KlebsFixBabyRustPlugin: Any + Send + Sync + Debug {

    fn klebs_fix_baby_rust(&self, 
        db:     salsa::Snapshot<RootDatabase>,
        config: &KlebsFixBabyRustConfig,
        file:   &SourceFile,
        range:  TextRange) -> TextEdit;

    fn name(&self) -> &str {
        std::any::type_name::<Self>()
    }
}
