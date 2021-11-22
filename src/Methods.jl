module Methods

import ..__QUAPY, ..QuaPyObject
import ..Datasets: LabelledCollection
export fit!, quantify

# BaseQuantifier interface
const BaseQuantifier = QuaPyObject{:BaseQuantifier}
fit!(q::BaseQuantifier, data::LabelledCollection; kwargs...) = q.fit(data.__object; kwargs...)
quantify(q::BaseQuantifier, instances) = q.quantify(instances)

# sklearn-style wrapper
fit!(q::BaseQuantifier, X::AbstractArray, y::AbstractVector{I}; kwargs...) where {I<:Integer} =
    fit!(q, LabelledCollection(X, y); kwargs...)

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
