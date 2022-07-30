crate::ix!();

fn first_attempt() {

    let text = Args::parse().text;

    let workspace_cargo_toml = cargo_toml();

    let manifest = ProjectManifest::from_manifest_file(workspace_cargo_toml).unwrap();

    let config = CargoConfig::default();

    let no_progress = &|_| ();

    let workspace = ProjectWorkspace::load(manifest, &config, no_progress).unwrap();

    let cg: Arc<CrateGraph> = Arc::new(to_crate_graph(workspace));

    let mut db = RootDatabase::default();

    db.set_crate_graph(cg.clone());

    let parse = SourceFile::parse(&text);

    println!("parse: {:?}", parse);

    assert!(parse.errors().is_empty());

    // The `tree` method returns an owned syntax node of type `SourceFile`.
    // Owned nodes are cheap: inside, they are `Rc` handles to the underling data.
    let file: SourceFile = parse.tree();

    // `SourceFile` is the root of the syntax tree. We can iterate file's items.
    // Let's fetch the `foo` function.
    let mut func = None;
    for item in file.items() {
        match item {
            ast::Item::Fn(f) => func = Some(f),
            _ => unreachable!(),
        }
    }

    let func: ast::Fn = func.unwrap();

    let name: Option<ast::Name> = func.name();
    let name = name.unwrap();
    assert_eq!(name.text(), "main");

    // Let's get the `1 + 1` expression!
    let body:      ast::BlockExpr = func.body().unwrap();
    let stmt_list: ast::StmtList = body.stmt_list().unwrap();
    let expr:      ast::Expr = stmt_list.tail_expr().unwrap();

    println!("expr: {:?}", expr);

    //DefWithBodyId
}
