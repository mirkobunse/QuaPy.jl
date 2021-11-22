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

# a mapping from module names to lists of methods
__METHODS = Dict(
    :aggregative => [
        :ClassifyAndCount, :CC,
        :AdjustedClassifyAndCount, :ACC,
        :ProbabilisticClassifyAndCount, :PCC,
        :ProbabilisticAdjustedClassifyAndCount, :PACC,
        :ExpectationMaximizationQuantifier, :EMQ,
        :HellingerDistanceY, :HDy,
        :ExplicitLossMinimisation, :ELM,
        :MedianSweep, :MS,
        :MedianSweep2, :MS2
    ],
    :non_aggregative => [
        :MaximumLikelihoodPrevalenceEstimation
    ],
    :meta => [
        :Ensemble, :ECC, :EACC, :EPACC, :EHDy, :EEMQ
    ]
)

# meta-programming: wrap the constructor of each quantification method
for (n, methods) in __METHODS
    for m in methods
        @eval $(m)(args...; kwargs...) =
            BaseQuantifier(__QUAPY.method.$(n).$(m)(args...; kwargs...))
    end
end

end # module
