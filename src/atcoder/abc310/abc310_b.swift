import Foundation

let line = readLine()!.split(separator: " ").map { Int($0)! }
let n = line[0]

var prices = [Int]()
var functions = [Set<Int>]()

for _ in 0..<n {
  let line = readLine()!.split(separator: " ").map { Int($0)! }
  prices.append(line[0])
  let cnt = line[1]
  var function = Set<Int>()
  for j in 0..<cnt {
    function.insert(line[j+2])
  }
  functions.append(function)
}

for i in 0..<n {
  for j in 0..<n {
    if prices[i] > prices[j] && functions[i].isSubset(of: functions[j]) {
      print("Yes")
      exit(0)
    }

    if prices[i] >= prices[j] && functions[i].isStrictSubset(of: functions[j]) {
      print("Yes")
      exit(0)
    }
  }
}
print("No")