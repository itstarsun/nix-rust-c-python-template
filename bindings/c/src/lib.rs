use std::ffi::{c_char, CString};

#[no_mangle]
pub extern "C" fn hello() -> *const c_char {
    CString::new(example::hello()).unwrap().into_raw()
}
