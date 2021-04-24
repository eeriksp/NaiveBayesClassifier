import Foundation

/// Add `predictTopic` method to `Model`
/// which will serve the `Model`'s primary purpose: making predictions.
/// That essential part is defined as an extension just for better code readability.
extension Model {
    /// Compute the probabilities of the given `content`
    /// belonging to each of the topics the model was trained on.
    public func predictTopic(_ content: [String]) -> PredictionResult {
        var probabilities = [Label: Double]()
        for topic in topics {
            probabilities[topic] = getProbabilityOfArticleBelongingToTopic(content: content, topic: topic)
        }
        return softmax(probabilities)
    }

    private func getProbabilityOfArticleBelongingToTopic(content: [String], topic: Label) -> Double {
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

public typealias PredictionResult = Dictionary<String, Double>

public extension PredictionResult {
    /// A convenience property to get the most likely label.
    var topLabel: Label {
        get {
            var mostLikelyTopic = ""
            var mostLikelyTopicProbability = -Double.infinity
            for (topic, prob) in self {
                if prob > mostLikelyTopicProbability {
                    mostLikelyTopic = topic
                    mostLikelyTopicProbability = prob
                }
            }
            return mostLikelyTopic
        }
    }
}
