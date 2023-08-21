let m = Int(readLine()!)!
let d = readLine()!.split(separator:" ").map { Int($0)! }
let mid = d.reduce(0, +) / 2

var mmdd = [[Int]]()
for i in 0..<m {
  for j in 1...d[i] {
    mmdd += [[i + 1, j]]
  }
}

print(mmdd[mid].map { String($0) }.joined(separator: " ") )
