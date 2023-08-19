//
// let a = readLine()!.split(separator: " ").map { Int($0)! }
// print(a.reduce(0, +) / n)
let values = Array((0..<8).map { i in [i, i] }.joined().shuffled())
print(values)