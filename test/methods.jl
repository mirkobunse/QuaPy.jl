@testset "Methods" begin
    svm = pyimport_conda("sklearn.svm", "scikit-learn").LinearSVC()
    dataset = QuaPy.Datasets.fetch_twitter("hcr")
    model = QuaPy.Methods.ClassifyAndCount(svm)
    QuaPy.Methods.fit!(model, QuaPy.Datasets.training(dataset))
    f_est = QuaPy.Methods.quantify(model, QuaPy.Datasets.instances(QuaPy.Datasets.test(dataset)))
    f_true = QuaPy.Datasets.prevalence(QuaPy.Datasets.test(dataset))
    @info "Prevalences of the 'hcr' test set" f_est f_true
end # Datasets
