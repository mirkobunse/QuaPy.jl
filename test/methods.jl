@testset "Methods" begin
    svm = pyimport_conda("sklearn.svm", "scikit-learn").LinearSVC()

    @testset "Random data" begin
        X = rand(Float64, (100, 5))
        y = rand(1:3, 100)
        cc = QuaPy.Methods.ClassifyAndCount(svm)
        QuaPy.fit!(cc, X, y)
        @info "Random LabelledCollection" quantify(cc, X)
    end

    @testset "hcr Twitter data set" begin
        dataset = QuaPy.Datasets.fetch_twitter("hcr")
        f_true = get_prevalence(get_test(dataset))
        mae(f_est) = mean(abs.(f_est - f_true))

        # evaluate methods
        maes = Dict{String,Float64}()
        for (name, method) in [
                "CC" => QuaPy.Methods.ClassifyAndCount(svm),
                "PACC" => QuaPy.Methods.PACC(svm),
                "EMQ" => QuaPy.Methods.EMQ(svm),
                "MLPrev" => QuaPy.Methods.MaximumLikelihoodPrevalenceEstimation(),
                "ECC" => QuaPy.Methods.ECC(svm)]
            QuaPy.fit!(method, get_training(dataset))
            f_est = quantify(method, get_instances(get_test(dataset)))
            push!(maes, name => mae(f_est))
        end
        @info "Performances the 'hcr' data set" f_true maes
    end

end # Methods
