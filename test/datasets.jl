@testset "Datasets" begin
    twitter_data = vcat(
        QuaPy.Datasets.twitter_sentiment_datasets_test(),
        QuaPy.Datasets.twitter_sentiment_datasets_training()
    )
    @testset "fetch_twitter $id" for id in twitter_data
        dataset = QuaPy.Datasets.fetch_twitter(id; for_model_selection=id=="semeval")
        QuaPy.Datasets.stats(QuaPy.Datasets.training(dataset))
    end # fetch_twitter
end # Datasets
