import Foundation

enum Muki {
  case Yoko
  case Tate

  var gyaku: Muki {
    return self == .Yoko ? .Tate : .Yoko
  }
}

struct MukiArray<T> {
  var a: [[T]]

  init(from: [[T]]) {
    self.a = from
  }

  subscript(d: Muki, i:Int, j:Int) -> T {
    get {
      switch d {
        case .Tate:
          return a[i][j]
        case .Yoko:
          return a[j][i]
      }
    }

    set(value) {
      switch d {
        case .Tate:
          self.a[i][j] = value
        case .Yoko:
          self.a[j][i] = value
      }
    }
  }
}

struct HashCount<K> {
  var h: [Int] = [Int](repeating: 0, count: 26)
  var sum: Int = 0

  subscript(k: K) -> Int {
    get {

    }
  }



}

var dic: [Muki: Int] = [.Yoko: 10, .Tate: 20]
var mukiArray = MukiArray(from: [[1,2,3],[4,5,6]])

print(dic[.Yoko.gyaku]!)
print(dic[.Tate.gyaku]!)
print(mukiArray[.Yoko, 0, 1])
// print(mukiArray[.Tate, 0, 1])
