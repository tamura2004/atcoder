func get2() -> (Int, Int) {
  let line = readLine()!.split(separator: " ").map { Int($0)! }
  return (line[0], line[1])
}

let (n, m) = get2()
var memo = [Double?](repeating: nil, count: m)

let roulettes = (0..<n).map { _ -> (Int, Int, Int, [Int]) in
  let line = readLine()!.split(separator: " ").map { Int($0)! }
  let c = line[0]
  let p = line[1]
  let s = Array(line[2...]).filter { v -> Bool in return v != 0 }
  let z = p - s.count
  return (c, p, z, s)
}

func dfs(memo : inout [Double?], roulettes : [(Int,Int,Int,[Int])], x : Int) -> Double {
  if x >= m {
    return 0.0
  }

  if let ans = memo[x] {
    return ans
  }

  var ans = 1e100

  for (c, p, z, s) in roulettes {
    var cnt = 0.0
    for y in s {
      cnt += dfs(memo: &memo, roulettes: roulettes, x: x + y)
    }
    cnt = (cnt + Double(p * c)) / Double(p - z)
    if ans > cnt {
      ans = cnt
    }
  }
  memo[x] = ans
  return ans
}

let ans = dfs(memo: &memo, roulettes: roulettes, x: 0)
print(ans)