module QuaPy

using Conda, PyCall

# import the Python package "quapy" into __QUAPY
const __QUAPY = PyNULL()
function __init__()
    quapy = pyimport_e("quapy")
    if ispynull(quapy) # need to install quapy?
        Conda.pip_interop(true)
        Conda.pip("install", "quapy")
        quapy = pyimport("quapy")
    end
    copy!(__QUAPY, quapy)
end

struct QuaPyObject{classname}
    __object::PyObject
end

include("Datasets.jl")
export Datasets

include("Methods.jl")
export Methods

end # module
