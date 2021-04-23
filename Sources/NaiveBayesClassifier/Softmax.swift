import Foundation

private let softmaxExponentBase = 1.1

/// Accept a dictionary mapping labels to numbers
/// and transform the numbers so that their total sum would always be 1.
/// Proportionally bigger input numbers will result in proportionally bigger output numbers.
///
/// For mathematical background and examples refer to https://en.wikipedia.org/wiki/Softmax_function
///
/// The exponent base `softmaxExponentBase` is set to 1.1 instead of e to make the numbers smaller.
/// When using e or any other bigger number as the exponent base,
/// the results will be so tiny that they evaluate to 0.
public func softmax(_ dict: [String: Double]) -> [String: Double] {
    let deliminator = sum(dict.values.map {
        pow(softmaxExponentBase, $0)
    })
    var softmaxDict = [String: Double]()
    for (label, value) in dict {
        softmaxDict[label] = pow(softmaxExponentBase, value) / deliminator
    }
    return softmaxDict
}

