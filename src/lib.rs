#![feature(test)]
extern crate test;

macro_rules! x { ($x:ident) => { mod $x; pub use $x::*; } }

#[macro_use] macro_rules! ix { 
    () => { 
        use crate::{ 
            imports::* , 
        };
    } 
}

#[macro_use] extern crate lazy_static;
#[macro_use] extern crate static_assertions;

mod imports;

x!{function}

#[no_mangle] pub extern "C" fn get_rust_fname(
    crate_json_db: *const libc::c_char,
    current_file:  *const libc::c_char,
    begin:         usize,
    end:           usize) -> *const libc::c_char {

    use crate::imports::*;

    let crate_json_db = unsafe { to_str(crate_json_db) };
    let current_file  = unsafe { to_str(current_file)  };

    let krate  = get_crate_descriptor(crate_json_db);
    let f_name = get_current_function_name(&krate, current_file, begin, end);

    CString::new(f_name).unwrap().into_raw()
}

#[repr(C)]
#[derive(Debug)]
pub struct LineRange {
    begin: u32,
    end:   u32,
}

#[no_mangle] pub extern "C" fn get_rust_current_function_linerange(
    crate_json_db: *const libc::c_char,
    current_file:  *const libc::c_char,
    begin:         usize,
    end:           usize) -> *mut LineRange {

    use crate::imports::*;

    let crate_json_db = unsafe { to_str(crate_json_db) };
    let current_file  = unsafe { to_str(current_file)  };

    let krate = get_crate_descriptor(crate_json_db);
    let span  = get_current_function_span(&krate, current_file, begin, end).unwrap();

    let range = Box::new(LineRange {
        begin: span.begin.0 as u32,
        end:   span.end.0   as u32,
    });

    Box::into_raw(range)
}
