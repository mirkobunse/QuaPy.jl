module Datasets

import ..__QUAPY

"""
    fetch_twitter(id)

Load the Twitter dataset with the given `id`.

**More information:** https://github.com/HLT-ISTI/QuaPy/wiki/Datasets#twitter-sentiment-datasets
"""
fetch_twitter(id::AbstractString; for_model_selection::Bool=false) =
    __QUAPY.datasets.fetch_twitter(id; for_model_selection=for_model_selection)

end # module
