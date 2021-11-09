using QuaPy
using Documenter

DocMeta.setdocmeta!(QuaPy, :DocTestSetup, :(using QuaPy); recursive=true)

makedocs(;
    modules=[QuaPy],
    authors="Mirko Bunse <mirko.bunse@cs.tu-dortmund.de> and contributors",
    repo="https://github.com/mirkobunse/QuaPy.jl/blob/{commit}{path}#{line}",
    sitename="QuaPy.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://mirkobunse.github.io/QuaPy.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/mirkobunse/QuaPy.jl",
    devbranch="main",
)
