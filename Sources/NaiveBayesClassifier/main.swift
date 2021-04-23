print(softmax(["a": -1, "b": 2, "c": 2.5]))
print(sum(softmax(["a": -1, "b": 2, "c": 2.5]).values.map {
    Double($0)
}))

let model = try Model(dataset: readArticlesFromCSV("data/bbc_train.csv"))
var hits = 0
var misses = 0
for article in try readArticlesFromCSV("data/bbc_test.csv") {
    let prediction = getMostLikelyTopic(model.predictTopic(article.content))
    if article.topic == prediction {
        hits += 1
    } else {
        misses += 1
    }
    print(article.topic, prediction, softmax(model.predictTopic(article.content)))
}
print("-------")
print("Hits: \(hits)")
print("Misses: \(misses)")

func getMostLikelyTopic(_ probabilities: [Topic: Double]) -> Topic {
    var mostLikelyTopic = ""
    var mostLikelyTopicProbability = -Double.infinity
    for (topic, prob) in probabilities {
        if prob > mostLikelyTopicProbability {
            mostLikelyTopic = topic
            mostLikelyTopicProbability = prob
        }
    }
    return mostLikelyTopic
}