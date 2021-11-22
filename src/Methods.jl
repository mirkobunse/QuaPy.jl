module Methods

import ..__QUAPY, ..QuaPyObject
import ..Datasets: LabelledCollection
export fit!, quantify

# BaseQuantifier interface
const BaseQuantifier = QuaPyObject{:BaseQuantifier}
fit!(x::BaseQuantifier, data::LabelledCollection; kwargs...) = x.fit(data.__object; kwargs...)
quantify(x::BaseQuantifier, instances) = x.quantify(instances)

ClassifyAndCount(args...; kwargs...) =
    BaseQuantifier(__QUAPY.method.aggregative.ClassifyAndCount(args...; kwargs...))

end # module
