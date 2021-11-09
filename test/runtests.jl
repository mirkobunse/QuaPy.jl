using QuaPy
using Test

@testset "DataSets" begin
    QuaPy.DataSets.fetch_twitter("semeval16"; for_model_selection=true)
end
