crate::ix!();

pub fn print_krate_deps(krate_data: &CrateData) {

    println!("---------------------------------");
    println!("name: {:?}", krate_data.display_name);

    let deps: Vec<_> = krate_data.dependencies.iter().map(|x| &x.name).collect();

    for dep in deps.iter() {
        println!("  {}", dep);
    }
}

pub fn print_krate_graph(crate_graph: &CrateGraph) {

    /*
    //println!("crate_graph: {:?}", crate_graph);

    let mut count = 0;

    for krate in crate_graph.iter() {

        let krate_data = &crate_graph[krate];

        //print_krate_deps(&krate_data);

        /*
        if count > 4 {
            break;
        }

        count += 1;
        */
    }
    */
}
