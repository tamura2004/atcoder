import Foundation

let line = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = line[0]
let k = line[1]

let ab = (0 ..< n).map { _ -> (Int, Int) in
  let line = readLine()!.split(separator: " ").map { Int(String($0))! }
  let a = line[0]
  let b = line[1]
  return ((a, b))
}
let abSorted = ab.sorted {
  $0.0 > $1.0
}

var cs = [0]
for (_, b) in ab {
  cs.append(cs[cs.count - 1] + b)
}

for i in 0 ... n {
  if (k < cs[i]) {
    print(ab[i-1].0 + 1)
    exit(0)
  }
}
print(1)