import Foundation

/// The `Model` will be initialized with a training dataset
/// which the model will use the learn the frequency of different words in different topics.
/// Then its `predictTopic` method (defined as an extension) can be used to compute the probabilities
/// that a given article belongs to any of the topics the model was trained on
/// and which are accessible through the `topics` property.
public struct Model {
    let topics: [Label]
    let wordCountByTopic: [Label: [String: Int]]
    let totalWordCountByTopic: [Label: Int]
    let uniqueWordCount: Int

    /// Initialize the `Model` and train it on the provided `dataset`.
    /// Note that the initialization can be quite slow
    /// as it involves the computationally intensive training.
    /// The model is ready to use for classification tasks as soon as it has been initialized.
    public init(dataset: [Article]) {
        wordCountByTopic = getWordCountByTopic(dataset)
        topics = Array(wordCountByTopic.keys)
        totalWordCountByTopic = getTotalWordCountByTopic(dataset)
        uniqueWordCount = getUniqueWordCount(dataset)
    }
}

private func getArticleCountByTopic(_ articles: [Article]) -> [Label: Int] {
    var count = [Label: Int]()
    for article in articles {
        count[article.label] = count[article.label] ?? 0 + 1
    }
    return count
}

private func getWordCountByTopic(_ articles: [Article]) -> [Label: [String: Int]] {
    var wordFrequencyCount = [Label: [String: Int]]()
    for article in articles {
        for word in article.content {
            if wordFrequencyCount[article.label] == nil {
                wordFrequencyCount[article.label] = [String: Int]()
            }
            let currentCount = wordFrequencyCount[article.label]?[word] ?? 0
            wordFrequencyCount[article.label]?[word] = currentCount + 1
        }
    }
    return wordFrequencyCount
}

private func getTotalWordCountByTopic(_ articles: [Article]) -> [Label: Int] {
    var count = [Label: Int]()
    for article in articles {
        count[article.label] = (count[article.label] ?? 0) + article.content.count
    }
    return count
}

private func getUniqueWordCount(_ articles: [Article]) -> Int {
    var words = Set<String>()
    for article in articles {
        words = words.union(article.content)
    }
    return words.count
}