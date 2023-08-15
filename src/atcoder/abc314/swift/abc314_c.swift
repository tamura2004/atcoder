let line = readLine()!.split(separator: " ").map { Int($0)! }
let n = line[0]
let m = line[1]
let s = Array(readLine()!)
let c = readLine()!.split(separator: " ").map { Int($0)! - 1 }

var cnt = [[Int]](
  repeating: [Int](),
  count: m
)

for i in 0..<n {
  cnt[c[i]].append(i)
}

var ans = [Int](repeating: -1, count: n)
for i in 0..<m {
  let k = cnt[i].count
  for j in 0..<k {
    ans[cnt[i][(j + 1) % k]] = cnt[i][j]
  }
}

print(String(ans.map {s[$0]}))