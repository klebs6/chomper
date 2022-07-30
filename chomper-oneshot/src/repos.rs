crate::ix!();

pub const BITCOIN_REPO: &'static str 
= "/Users/kleb/bethesda/work/repo/bitcoin-rs";

pub const SURGE_REPO:   &'static str 
= "/Users/kleb/bethesda/work/repo/surge-rs";

pub fn bitcoin_cargo_toml() -> PathBuf {
    cargo_toml(BITCOIN_REPO)
}

pub fn surge_cargo_toml() -> PathBuf {
    cargo_toml(SURGE_REPO)
}

pub fn blitter_cargo_toml() -> PathBuf {
    workspace_crate_cargo_toml(SURGE_REPO, "surge-blitter")
}


pub const TEMP_REPO:   &'static str 
= "/tmp/scratch";

pub fn cargo_toml(repo: &str) -> PathBuf {
    let mut pb = PathBuf::from(repo);
    pb.push("Cargo.toml");
    pb
}

pub fn workspace_crate_cargo_toml(ws: &str, krate: &str) -> PathBuf {
    let mut pb = PathBuf::from(ws);
    pb.push(krate);
    pb.push("Cargo.toml");
    pb
}

pub fn temp_cargo_toml() -> PathBuf {
    cargo_toml(TEMP_REPO)
}

pub fn abs_path_buf(pb: PathBuf) -> AbsPathBuf {
    AbsPathBuf::try_from(pb).unwrap()
}
