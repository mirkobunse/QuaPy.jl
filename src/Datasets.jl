module Datasets

import ..__QUAPY, ..QuaPyObject
export
    get_instances,
    get_labels,
    get_classes,
    get_prevalence,
    get_counts,
    is_binary,
    get_stats,
    get_training,
    get_test,
    get_vocabulary

# lists of Dataset IDs
reviews_sentiment_datasets() = __QUAPY.datasets.REVIEWS_SENTIMENT_DATASETS
twitter_sentiment_datasets_test() = __QUAPY.datasets.TWITTER_SENTIMENT_DATASETS_TEST
twitter_sentiment_datasets_training() = __QUAPY.datasets.TWITTER_SENTIMENT_DATASETS_TRAIN
uci_datasets() = __QUAPY.datasets.UCI_DATASETS

# LabelledCollection interface
const LabelledCollection = QuaPyObject{:LabelledCollection}
get_instances(x::LabelledCollection) = x.instances
get_labels(x::LabelledCollection) = x.labels
get_classes(x::LabelledCollection) = x.classes_
get_prevalence(x::LabelledCollection) = x.prevalence()
get_counts(x::LabelledCollection) = x.counts()
is_binary(x::LabelledCollection) = x.binary
get_stats(x::LabelledCollection; show::Bool=true) = x.stats(; show=show)

# Dataset interface
const Dataset = QuaPyObject{:Dataset}
get_training(x::Dataset) = LabelledCollection(x.training)
get_test(x::Dataset) = LabelledCollection(x.test)
get_vocabulary(x::Dataset) = x.vocabulary
get_classes(x::Dataset) = x.classes_
is_binary(x::Dataset) = x.binary
get_stats(x::Dataset) = x.stats()

"""
    fetch_twitter(id)

Load the Twitter dataset with the given `id`.

**More information:** https://github.com/HLT-ISTI/QuaPy/wiki/Datasets#twitter-sentiment-datasets
"""
fetch_twitter(id::AbstractString; for_model_selection::Bool=false) =
    Dataset(__QUAPY.datasets.fetch_twitter(id; for_model_selection=for_model_selection))

end # module
