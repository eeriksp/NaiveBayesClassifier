import Foundation

public typealias Label = String

public struct Article {
    let label: Label
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
    return Article(label: topic, content: content)
}

/// Turns the content string into an array of words by removing
/// quotation marks used to encapsulate the CSV column,
/// enforcing lowercase
/// and filtering out very short words.
private func cleanContent(_ content: String) -> [String] {
    cleansText(String(String(content.dropFirst().dropLast())))
}

private func readLinesFromCSV(_ filename: String) throws -> [String] {
    let content = try String(contentsOf: URL(fileURLWithPath: filename))
    return content.split {
        $0.isNewline
    }.map(String.init)
}


