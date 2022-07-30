crate::ix!();

pub fn to_crate_graph(project_workspace: ProjectWorkspace) -> CrateGraph {
    project_workspace.to_crate_graph(&mut |_, _| Ok(Vec::new()), &mut {
        let mut counter = 0;
        move |_path| {
            counter += 1;
            Some(FileId(counter))
        }
    })
}

