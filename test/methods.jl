@testset "Methods" begin
    svm = pyimport_conda("sklearn.svm", "scikit-learn").LinearSVC()
    dataset = QuaPy.Datasets.fetch_twitter("hcr")
    model = QuaPy.Methods.ClassifyAndCount(svm)
    fit!(model, get_training(dataset))
    f_est = quantify(model, get_instances(get_test(dataset)))
    f_true = get_prevalence(get_test(dataset))
    @info "Prevalences of the 'hcr' test set" f_est f_true
end # Datasets
