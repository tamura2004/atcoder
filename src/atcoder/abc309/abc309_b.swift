let n = Int(readLine()!)!
var a = (0 ..< n).map { _ in
  Array(readLine()!).map { Int(String($0))! }
}

var b = a
var (x, y, vx, vy) = (0, 0, 0, 1)

for _ in 1 ... 4 {
  for _ in 1 ... (n - 1) {
    b[y][x] = a[y + vy][x + vx]
    y += vy
    x += vx
  }
  (vx, vy) = (vy, -vx)
}

for i in 0 ..< n {
  print(b[i].map {String($0) }.joined())
}

