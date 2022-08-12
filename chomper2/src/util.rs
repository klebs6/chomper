
// this is literally just for sanity checking in
// a situation where stderr is not captured and
// neither is `tracing` functional
pub fn write_stupid_file(file: &str, data: Option<&str>) {

    let msg = match data {
        Some(data) => data.to_string(),
        None => {
            let val: i32 = match std::fs::read_to_string(file) {
                Ok(s) => {
                    match s.parse() {
                        Ok(parsed) => parsed,
                        Err(_)     => 0,
                    }
                },
                Err(_) => 0,
            };

            format!{"{}",val + 1}
        }
    };

    std::fs::write(file, msg).expect("Unable to write file");
}
