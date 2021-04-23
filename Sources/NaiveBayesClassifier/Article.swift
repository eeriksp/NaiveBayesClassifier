import Foundation

// TODO Perhaps rename to `Label`
public typealias Topic = String

public struct Article {
    let topic: Topic
    let content: [String]
}

func readArticlesFromCSV(_ filename: String) throws -> [Article] {
    try readLinesFromCSV(filename).map(constructArticleFromLine)
}

/// Constructs an `Article` from one line from the CSV input file.
private func constructArticleFromLine(_ line: String) -> Article {
    let topicAndContent = line.split(separator: ",", maxSplits: 1).map(String.init)
    let topic = topicAndContent[0]
    let content = cleanContent(topicAndContent[1])
    return Article(topic: topic, content: content)
}

/// Turns the content string into an array of words by removing
/// quotation marks used to encapsulate the CSV column,
/// enforcing lowercase
/// and filtering out very short words.
private func cleanContent(_ content: String) -> [String] {
    let words = String(String(content.dropFirst().dropLast())
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\"", with: ""))
            .lowercased().split(separator: " ")
    return words.filter {
        $0.count > 3
    }.map(String.init)
}

private func readLinesFromCSV(_ filename: String) throws -> [String] {
    let content = try String(contentsOf: URL(fileURLWithPath: filename))
    return content.split { $0.isNewline }.map(String.init)
}


