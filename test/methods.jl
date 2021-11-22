@testset "Methods" begin
    svm = pyimport_conda("sklearn.svm", "scikit-learn").LinearSVC()

    @testset "Random data" begin
        X = rand(Float64, (100, 5))
        y = rand(1:3, 100)
        cc = QuaPy.Methods.ClassifyAndCount(svm)
        fit!(cc, X, y)
        @info "Random LabelledCollection" quantify(cc, X)
    end

    @testset "hcr Twitter data set" begin
        dataset = QuaPy.Datasets.fetch_twitter("hcr")
        f_true = get_prevalence(get_test(dataset))

        # ClassifyAndCount
        cc = QuaPy.Methods.ClassifyAndCount(svm)
        fit!(cc, get_training(dataset))
        f_cc = quantify(cc, get_instances(get_test(dataset)))

        # AdjustedClassifyAndCount
        acc = QuaPy.Methods.AdjustedClassifyAndCount(svm)
        fit!(acc, get_training(dataset))
        f_acc = quantify(acc, get_instances(get_test(dataset)))

        # ProbabilisticClassifyAndCount
        pcc = QuaPy.Methods.PCC(svm)
        fit!(pcc, get_training(dataset))
        f_pcc = quantify(pcc, get_instances(get_test(dataset)))

        # ProbabilisticAdjustedClassifyAndCount
        pacc = QuaPy.Methods.PACC(svm)
        fit!(pacc, get_training(dataset))
        f_pacc = quantify(pacc, get_instances(get_test(dataset)))

        # ExpectationMaximizationQuantifier
        emq = QuaPy.Methods.EMQ(svm)
        fit!(emq, get_training(dataset))
        f_emq = quantify(emq, get_instances(get_test(dataset)))

        @info "Prevalences of the 'hcr' test set" f_true f_cc f_acc f_pcc f_pacc f_emq
    end

end # Methods
