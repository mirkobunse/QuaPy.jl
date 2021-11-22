@testset "Datasets" begin

    @testset "Constructors" begin
        # wrap random data in a LabelledCollection
        X = rand(Float64, (100, 5))
        y = rand(1:3, 100)
        lc = QuaPy.Datasets.LabelledCollection(X, y)

        # make sure that the wrapper works
        svm = pyimport_conda("sklearn.svm", "scikit-learn").LinearSVC()
        cc = QuaPy.Methods.ClassifyAndCount(svm)
        fit!(cc, lc)
        f_cc = quantify(cc, X)
        f_true = get_prevalence(lc)
        @info "Random LabelledCollection" f_true f_cc
    end

    twitter_data = vcat(
        QuaPy.Datasets.twitter_sentiment_datasets_test(),
        QuaPy.Datasets.twitter_sentiment_datasets_training()
    )
    @testset "fetch_twitter $id" for id in twitter_data
        dataset = QuaPy.Datasets.fetch_twitter(id; for_model_selection=id=="semeval")
        QuaPy.Datasets.get_stats(QuaPy.Datasets.get_training(dataset))
    end # fetch_twitter

end # Datasets
