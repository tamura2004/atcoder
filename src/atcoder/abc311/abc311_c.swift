let n = Int(readLine()!)!
let nex = readLine()!.split(separator: " ").map { Int($0)! - 1 }
var ord = [Int](repeating: -1, count: n)
var visit: [Int] = []

var v = 0
var root = -1
while true {
  ord[v] = visit.count
  visit.append(v)

  let nv = nex[v]
  if ord[nv] != -1 {
    root = ord[nv]
    break
  }

  v = nv
}

let cycle = visit[root ..< visit.count]
print(cycle.count)
print(cycle.map { String($0 + 1) }.joined(separator: " "))
