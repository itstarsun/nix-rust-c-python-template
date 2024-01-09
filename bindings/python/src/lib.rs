use pyo3::prelude::*;

#[pyfunction]
fn hello() -> PyResult<&'static str> {
    Ok(example::hello())
}

#[pymodule]
fn _example(_py: Python, m: &PyModule) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(hello, m)?)?;
    Ok(())
}
