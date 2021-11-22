module Methods

import ..__QUAPY, ..QuaPyObject
import ..Datasets: LabelledCollection
export fit!, quantify

# BaseQuantifier interface
const BaseQuantifier = QuaPyObject{:BaseQuantifier}
fit!(x::BaseQuantifier, data::LabelledCollection; kwargs...) = x.fit(data.__object; kwargs...)
quantify(x::BaseQuantifier, instances) = x.quantify(instances)

# meta-programming: wrap the constructor of each aggregative method
for c in [
        :ClassifyAndCount, :CC,
        :AdjustedClassifyAndCount, :ACC,
        :ProbabilisticClassifyAndCount, :PCC,
        :ProbabilisticAdjustedClassifyAndCount, :PACC,
        :ExpectationMaximizationQuantifier, :EMQ,
        :HellingerDistanceY, :HDy,
        :ExplicitLossMinimisation, :ELM,
        :MedianSweep, :MS,
        :MedianSweep2, :MS2]
    @eval $(c)(args...; kwargs...) =
        BaseQuantifier(__QUAPY.method.aggregative.$(c)(args...; kwargs...))
end

end # module
