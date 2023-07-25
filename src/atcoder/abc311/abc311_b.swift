let arr = readLine()!.split(separator: " ").map { Int($0)! }
let n = arr[0]
let d = arr[1]
var s : [[Character]] = []
for _ in 0 ..< n { s.append(Array(readLine()!)) }

var ans = 0
var cnt = 0

for i in 0 ..< d {
  var allSatisfy = true
  for j in 0 ..< n {
    if s[j][i] == "x" {
      allSatisfy = false
    }
  }

  if allSatisfy {
    cnt += 1
    if ans < cnt {
      ans = cnt
    }
  } else {
    cnt = 0
  }
}

print(ans)