@testset "Methods" begin
    svm = pyimport_conda("sklearn.svm", "scikit-learn").LinearSVC()
    dataset = QuaPy.Datasets.fetch_twitter("hcr")
    model = QuaPy.Methods.ClassifyAndCount(svm)
    fit!(model, training(dataset))
    f_est = quantify(model, QuaPy.instances(test(dataset)))
    f_true = prevalence(test(dataset))
    @info "Prevalences of the 'hcr' test set" f_est f_true
end # Datasets
