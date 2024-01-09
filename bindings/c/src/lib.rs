use std::ffi::{c_char, CString};

#[no_mangle]
pub extern "C" fn hello() -> *mut c_char {
    CString::new(example::hello()).unwrap().into_raw()
}
