ix!();

use crate::*;

pub unsafe fn to_str<'a>(x: *const libc::c_char) -> &'a str {
    let c_str: &CStr = CStr::from_ptr(x);
    c_str.to_str().unwrap()
}

pub fn get_crate_descriptor(crate_json_db: &str) -> Crate {

    let contents = read_to_string(format!("{}.unfold", crate_json_db))
        .expect(format!("Something went wrong reading the file {}",crate_json_db).as_str());

    let deserialized: Crate = serde_json::from_str(&contents).unwrap();

    deserialized
}

pub fn is_subspan(inner: &Span, outer: &Span) -> bool {
    inner.filename == outer.filename 
        && inner.begin.0 >= outer.begin.0 
        && inner.end.0   <= outer.end.0 
}

pub fn get_current_function_name(
    krate:    &Crate,
    filename: &str,
    begin:    usize,
    end:      usize) -> String {

    let model = model_span(filename,begin,end);

    for item in krate.index.iter() {
        if let Some(ref span) = item.1.span {
            if is_subspan(&model,span) {
                if let Some(ref name) = item.1.name {
                    return name.clone();
                }
            }
        }
    }

    "<none>".to_string()
}

pub fn model_span(filename: &str, begin: usize, end: usize) -> Span {
    Span {
        filename: PathBuf::from(filename),
        begin:    (begin, 0),
        end:      (end, 0),
    }
}

pub fn get_current_function_span(
    krate:    &Crate,
    filename: &str,
    begin:    usize,
    end:      usize) -> Option<Span> {

    let model = model_span(filename,begin,end);

    let mut map: HashMap<usize,Span> = HashMap::default();

    for item in krate.index.iter() {
        if let Some(ref span) = item.1.span {
            if is_subspan(&model,span) {
                let range: usize = span.end.0 - span.begin.0;
                map.insert(range,span.clone());
            }
        }
    }

    //we want the span with the tightest range,
    //aka the minimum range

    let min = map
        .iter()
        .min_by(|a, b| a.0.partial_cmp(&b.0).expect("Found a NaN"));

    match min {
        Some(min) => Some(min.1.clone()),
        None      => None,
    }
}
