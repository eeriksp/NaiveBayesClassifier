public extension Model {
    func testAccuracy(dataset: [Article]) -> ModelAccuracyTest {
        var hits = [Article]()
        var misses = [Article]()
        for article in dataset {
            let prediction = predictTopic(article.content).topLabel
            if article.topic == prediction {
                hits.append(article)
            } else {
                misses.append(article)
            }
        }
        return ModelAccuracyTest(hits: hits, misses: misses)
    }
}

public struct ModelAccuracyTest {
    public let hits: [Article]
    public let misses: [Article]
}