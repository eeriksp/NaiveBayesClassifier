import Foundation

/// Calculate the sum of all the numbers in the given array.
func sum(_ n: [Double]) -> Double {
    n.reduce(0, +)
}