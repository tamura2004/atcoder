//
// let a = readLine()!.split(separator: " ").map { Int($0)! }
// print(a.reduce(0, +) / n)

// 座標圧縮
struct CC {
  var keys: [Int]
  var refs: [Int]

  init(keys: [Int]) {
    self.keys = keys
    refs = [Int]()
    for key in keys.sorted() {
      if refs.isEmpty || refs.last != key {
        refs.append(key)
      }
    }
  }

  func index(_ key: Int) -> Int {
    var lo = 0
    var hi = refs.count
    while hi - lo > 1 {
      let mid = (lo + hi) / 2
      if refs[mid] <= key {
        lo = mid
      } else {
        hi = mid
      }
    }
    return lo
  }
}

let cc = CC(keys: [3,1,4,1,5])
print(cc.index(1))
print(cc.index(3))
print(cc.index(4))
print(cc.index(5))