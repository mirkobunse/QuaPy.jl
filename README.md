# QuaPy.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://mirkobunse.github.io/QuaPy.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://mirkobunse.github.io/QuaPy.jl/dev)
[![Build Status](https://github.com/mirkobunse/QuaPy.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/mirkobunse/QuaPy.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/mirkobunse/QuaPy.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/mirkobunse/QuaPy.jl)

A Julia wrapper for [QuaPy](https://github.com/HLT-ISTI/QuaPy), the open source framework for quantification.

## Installation

Use the Julia package manager to install QuaPy.jl from GitHub:

```
pkg> add https://github.com/mirkobunse/QuaPy.jl.git
```

## Usage

This wrapper works similar to the original QuaPy package. However, some aspects of the original Python API have been adapted to be more Juliesque.

```julia
using QuaPy, PyCall

# import the linear SVM from scikit-learn
svm = pyimport_conda("sklearn.svm", "scikit-learn").LinearSVC()

# fetch data from QuaPy
dataset = QuaPy.Datasets.fetch_twitter("hcr")
p_true = get_prevalence(get_test(dataset))

# estimate the class prevalences with the ACC method
acc = QuaPy.Methods.AdjustedClassifyAndCount(svm)
QuaPy.fit!(acc, get_training(dataset))
p_acc = quantify(acc, get_instances(get_test(dataset)))

@info "Prevalences of the 'hcr' data" p_true p_acc
```
