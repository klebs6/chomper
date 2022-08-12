#![feature(io_read_to_string)]

#[macro_export] macro_rules! x { 
    ($x:ident) => { 
        mod $x; 
        pub use $x::*; 
    }
}

#[macro_export] macro_rules! ix { 
    () => { 
        use crate::{ 
            imports::* , 
        };
        use crate::*;
    } 
}

pub use ide::*;

pub use syntax::{
    NodeOrToken,
    TextSize,
    AstNode,
    SourceFile,
    TextRange
};

pub use text_edit::TextEdit;
pub use ctor::ctor;

pub use tracing_log::LogTracer;
pub use log;

pub use tracing::{info, Level};
pub use tracing_subscriber::{FmtSubscriber,EnvFilter};
pub use tracing_subscriber::fmt::writer::{BoxMakeWriter,MakeWriter};
pub use std::sync::Arc;
pub use std::path::Path;
pub use std::io;
pub use std::fs::File;
pub use lazy_static::lazy_static;

//pub use rustdoc_json_types_fork::*;
pub use rustdoc_types::*;
pub use std::ffi::{CStr,CString};
pub use std::fs::*;
pub use std::path::*;
pub use std::collections::*;

pub use std::sync::*;

pub use anyhow;

pub use rustc_hash::{FxHashSet,FxHashMap};

pub use libc;

pub use clap::{
    Parser,
};

pub use std::path::*;
pub use std::collections::*;

pub use std::io::*;

pub use std::io::{
    Read,
    read_to_string,
};

/*
pub use ra_ap_rust_analyzer::{
    cli,
    cli::load_cargo::*,
};

pub use ra_ap_syntax::{
    ast,
    ast::{
        HasModuleItem,
        HasName,
        AstNode,
    },
    SourceFile,
};

pub use ra_ap_ide_db::{
    RootDatabase,
    base_db::SourceDatabaseExt,
};

pub use ra_ap_base_db::{
    CrateGraph,
    SourceDatabase,
    //SourceDatabaseExt,
    CrateName,
    CrateData,
};

pub use ra_ap_hir as hir;

pub use ra_ap_hir_ty::{
    db::HirDatabase,
};

pub use ra_ap_hir::{
    Crate,
    Module,
};

pub use ra_ap_vfs::{
    FileId,
};

pub use ra_ap_project_model::{
    ProjectWorkspace,
    ProjectManifest,
    CargoConfig,
};

pub use ra_ap_paths::{
    AbsPath,
    AbsPathBuf,
};
*/

