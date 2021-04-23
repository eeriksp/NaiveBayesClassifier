let model = try Model(articles: readArticlesFromCSV("data/bbc_train.csv"))
var hits = 0
var misses = 0
for article in try readArticlesFromCSV("data/bbc_test.csv") {
    let prediction = getMostLikelyTopic(model.predictTopic(article.content))
    if article.topic == prediction {
        hits += 1
    } else {
        misses += 1
    }
    print(article.topic, prediction)
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