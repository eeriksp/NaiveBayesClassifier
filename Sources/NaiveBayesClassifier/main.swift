let model = try Model(dataset: readArticlesFromCSV("data-big/bbc_train.csv"))
let testResult = try model.testAccuracy(dataset: readArticlesFromCSV("data-big/bbc_test.csv"))
print("Hits: \(testResult.hits.count)")
print("Misses: \(testResult.misses.count)")
