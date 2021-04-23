import Foundation

/// See https://en.wikipedia.org/wiki/Softmax_function
public func softmax(_ dict: [String: Double]) -> [String: Double] {
    let logDenominator = sum(dict.values.map {
        pow(1.1, $0)
    })
    var softmaxDict = [String: Double]()
    for (label, value) in dict {
        softmaxDict[label] = pow(1.1, value) / logDenominator
    }
    return softmaxDict
}