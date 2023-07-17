let n = Int(readLine()!)!
var uniq = Set<String>()
var count = Set<String>()

for _ in 0..<n {
  let s = readLine()!
  let r = String(s.reversed())
  if s == r {
    uniq.insert(s)
  } else {
    count.insert(s)
    count.insert(r)
  }
}

print(count.count / 2 + uniq.count)