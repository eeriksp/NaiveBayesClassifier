import Foundation

struct Model {
    private let topics: [Topic]
    private let wordCountByTopic: [Topic: [String: Int]]
    private let totalWordCountByTopic: [Topic: Int]
    private let uniqueWordCount: Int

    init(articles: [Article]) {
        wordCountByTopic = getWordCountByTopic(articles)
        topics = Array(wordCountByTopic.keys)
        totalWordCountByTopic = getTotalWordCountByTopic(articles)
        uniqueWordCount = getUniqueWordCount(articles)
    }

    func predictTopic(_ content: [String]) -> [Topic: Double] {
        var probabilities = [Topic: Double]()
        for topic in topics {
            probabilities[topic] = getProbabilityOfArticleBelongingToTopic(content: content, topic: topic)
        }
        return probabilities
    }

    private func getProbabilityOfArticleBelongingToTopic(content: [String], topic: Topic) -> Double {
        var probability = 1.0
        for word in content {
            probability += log(getWordOccurrenceProbabilityGivenTopic(word: word, topic: topic))
        }
        return probability
    }

    private func getWordOccurrenceProbabilityGivenTopic(word: String, topic: String) -> Double {
        // the +1 at the end of next line prevents the result value from ever evaluating to zero
        let wordOccurrencesInCategory = (wordCountByTopic[topic]?[word] ?? 0) + 1
        return Double(wordOccurrencesInCategory) / Double((totalWordCountByTopic[topic] ?? 0) + uniqueWordCount)
    }
}


private func getArticleCountByTopic(_ articles: [Article]) -> [Topic: Int] {
    var count = [Topic: Int]()
    for article in articles {
        count[article.topic] = count[article.topic] ?? 0 + 1
    }
    return count
}

private func getWordCountByTopic(_ articles: [Article]) -> [Topic: [String: Int]] {
    var wordFrequencyCount = [Topic: [String: Int]]()
    for article in articles {
        for word in article.content {
            if wordFrequencyCount[article.topic] == nil {
                wordFrequencyCount[article.topic] = [String: Int]()
            }
            let currentCount = wordFrequencyCount[article.topic]?[word] ?? 0
            wordFrequencyCount[article.topic]?[word] = currentCount + 1
        }
    }
    return wordFrequencyCount
}

private func getTotalWordCountByTopic(_ articles: [Article]) -> [Topic: Int] {
    var count = [Topic: Int]()
    for article in articles {
        count[article.topic] = (count[article.topic] ?? 0) + article.content.count
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