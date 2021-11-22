module Datasets

import ..__QUAPY, ..QuaPyObject

# lists of Dataset IDs
reviews_sentiment_datasets() = __QUAPY.datasets.REVIEWS_SENTIMENT_DATASETS
twitter_sentiment_datasets_test() = __QUAPY.datasets.TWITTER_SENTIMENT_DATASETS_TEST
twitter_sentiment_datasets_training() = __QUAPY.datasets.TWITTER_SENTIMENT_DATASETS_TRAIN
uci_datasets() = __QUAPY.datasets.UCI_DATASETS

# LabelledCollection interface
const LabelledCollection = QuaPyObject{:LabelledCollection}
instances(x::LabelledCollection) = x.__object.instances
labels(x::LabelledCollection) = x.__object.labels
classes(x::LabelledCollection) = x.__object.classes_
prevalence(x::LabelledCollection) = x.__object.prevalence()
counts(x::LabelledCollection) = x.__object.counts()
is_binary(x::LabelledCollection) = x.__object.binary
stats(x::LabelledCollection; show::Bool=true) = x.__object.stats(; show=show)

# Dataset interface
const Dataset = QuaPyObject{:Dataset}
training(x::Dataset) = LabelledCollection(x.__object.training)
test(x::Dataset) = LabelledCollection(x.__object.test)
vocabulary(x::Dataset) = x.__object.vocabulary
classes(x::Dataset) = x.__object.classes_
is_binary(x::Dataset) = x.__object.binary
stats(x::Dataset) = x.__object.stats()

"""
    fetch_twitter(id)

Load the Twitter dataset with the given `id`.

**More information:** https://github.com/HLT-ISTI/QuaPy/wiki/Datasets#twitter-sentiment-datasets
"""
fetch_twitter(id::AbstractString; for_model_selection::Bool=false) =
    Dataset(__QUAPY.datasets.fetch_twitter(id; for_model_selection=for_model_selection))

end # module
