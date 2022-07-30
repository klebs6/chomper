#![feature(io_read_to_string)]

#[macro_use] mod imports; use imports::*;

mod cli_args; use cli_args::*;
mod example;  use example::*;
mod function; use function::*;
mod repos;    use repos::*;

fn all_modules(db: &dyn HirDatabase) -> Vec<Module> {

    println!("func: all_modules");

    let mut worklist: Vec<_> =
    Crate::all(db).into_iter().map(|krate| {
        println!("processing krate: {:?}", krate);
        krate.root_module(db)
    }).collect();

    let mut modules = Vec::new();

    println!("hangs before it gets here");

    while let Some(module) = worklist.pop() {

        println!("--module: {:?}", module.name(db));

        modules.push(module);
        worklist.extend(module.children(db));
    }

    modules
}

fn main() -> anyhow::Result<()> {

    let path = bitcoin_cargo_toml();

    println!("cargo-toml: {}", path.as_os_str().to_str().unwrap());

    let cargo_config = Default::default();

    let load_cargo_config = LoadCargoConfig {
        load_out_dirs_from_check: false,
        with_proc_macro:          false,
        prefill_caches:           false,
    };

    let (host, _vfs, _proc_macro) =
    load_workspace_at(&path, &cargo_config, &load_cargo_config, &|_| {})?;

    println!("host: {:?}", host);

    let db       = host.raw_database();
    let analysis = host.analysis();

    let mut found_error = false;
    let mut visited_files: FxHashSet<FileId> = FxHashSet::default();

    let modules = all_modules(db);

    Ok(())
}
