module Datasets

import ..__QUAPY, ..QuaPyObject
export
    instances,
    labels,
    classes,
    prevalence,
    counts,
    is_binary,
    stats,
    training,
    test,
    vocabulary

# lists of Dataset IDs
reviews_sentiment_datasets() = __QUAPY.datasets.REVIEWS_SENTIMENT_DATASETS
twitter_sentiment_datasets_test() = __QUAPY.datasets.TWITTER_SENTIMENT_DATASETS_TEST
twitter_sentiment_datasets_training() = __QUAPY.datasets.TWITTER_SENTIMENT_DATASETS_TRAIN
uci_datasets() = __QUAPY.datasets.UCI_DATASETS

# LabelledCollection interface
const LabelledCollection = QuaPyObject{:LabelledCollection}
instances(x::LabelledCollection) = x.instances
labels(x::LabelledCollection) = x.labels
classes(x::LabelledCollection) = x.classes_
prevalence(x::LabelledCollection) = x.prevalence()
counts(x::LabelledCollection) = x.counts()
is_binary(x::LabelledCollection) = x.binary
stats(x::LabelledCollection; show::Bool=true) = x.stats(; show=show)

# Dataset interface
const Dataset = QuaPyObject{:Dataset}
training(x::Dataset) = LabelledCollection(x.training)
test(x::Dataset) = LabelledCollection(x.test)
vocabulary(x::Dataset) = x.vocabulary
classes(x::Dataset) = x.classes_
is_binary(x::Dataset) = x.binary
stats(x::Dataset) = x.stats()

"""
    fetch_twitter(id)

Load the Twitter dataset with the given `id`.

**More information:** https://github.com/HLT-ISTI/QuaPy/wiki/Datasets#twitter-sentiment-datasets
"""
fetch_twitter(id::AbstractString; for_model_selection::Bool=false) =
    Dataset(__QUAPY.datasets.fetch_twitter(id; for_model_selection=for_model_selection))

end # module
