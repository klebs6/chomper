crate::ix!();

pub fn setup_logging() {

    let logpath = std::env::var("RA_PLUGIN_LOG_FILE").ok();
    let logflag = std::env::var("RA_PLUGIN_LOG").ok();

    let msg = format!{
        "in function setup_logging with RA_PLUGIN_LOG_FILE={} and RA_PLUGIN_LOG={}",
        logpath.as_ref().unwrap(),
        logflag.as_ref().unwrap(),
    };

    let file = match logpath {
        Some(p) => match File::create(p) {
            Ok(f)  => Some(f),
            Err(_e) => None,
        },
        None    => None,
    };

    let writer = match file {
        Some(file) => BoxMakeWriter::new(Arc::new(file)),
        None       => BoxMakeWriter::new(io::stderr),
    };

    // a builder for `FmtSubscriber`.
    let subscriber = FmtSubscriber::builder()
        // all spans/events with a level higher than TRACE (e.g, debug, info, warn, etc.)
        // will be written to stdout.
        .with_max_level(Level::INFO)
        .with_env_filter(EnvFilter::from_env("RA_PLUGIN_LOG"))
        .with_writer(writer)
        // completes the builder.
        .finish();

    tracing::subscriber::set_global_default(subscriber)
        .expect("setting default subscriber failed");

    tracing::info!("test trace info from chomper2!");
}

#[ctor] fn ctor_setup_logging() {

    setup_logging();
}
