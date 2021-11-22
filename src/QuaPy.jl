module QuaPy

using Conda, PyCall, Reexport

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
Base.getproperty(x::QuaPyObject, p::Symbol) =
    p==:__object ? getfield(x, p) : getproperty(x.__object, p)

include("Datasets.jl")
@reexport using .Datasets
using .Datasets: instances # solve the naming conflict with Base.instances
export instances

include("Methods.jl")
@reexport using .Methods

end # module
