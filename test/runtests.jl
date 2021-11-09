using QuaPy
using Test

@testset "Datasets" begin
    QuaPy.Datasets.fetch_twitter("semeval16"; for_model_selection=true)
end
