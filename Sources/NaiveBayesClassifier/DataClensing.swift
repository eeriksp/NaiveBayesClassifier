typealias Cleanser = (String) -> String

/// Turn a string af input data into a list of words,
/// remove some punctuation, remove very shore words and enforce lowercase.
func cleansText(_ text: String) -> [String] {
    let words = text.removeAllOccurrencesOf(punctuation).lowercased().split(separator: " ")
    return words.filter {
        $0.count > 3
    }.map(String.init)
}


private let punctuation = "!.,?\":;()".map(String.init)