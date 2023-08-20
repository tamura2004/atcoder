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

  var count: Int {
    refs.count
  }
}

func get3() -> (Int,Int,Int) {
  let line = readLine()!.split(separator: " ").map { Int($0)! }
  return (line[0], line[1], line[2])
}

func get4() -> (Int,Int,Int,Int) {
  let line = readLine()!.split(separator: " ").map { Int($0)! }
  return (line[0], line[1], line[2], line[3])
}

struct Elevator: Comparable {
  var lo: Int
  var hi: Int

  static func < (a: Elevator, b: Elevator) -> Bool {
    if a.lo == b.lo {
      return a.hi < b.hi
    } else {
      return a.lo < b.lo
    }
  }
}

let (n, m, q) = get3()
var buildings = [[Elevator]](
  repeating: [Elevator](),
  count: n
)

// ビルごとにエレベーターを読み込んでまとめる
for _ in 0..<m {
  let (_i, lo, hi) = get3()
  let i = _i - 1
  buildings[i].append(Elevator(lo: lo, hi: hi))
}

// ビルごとのエレベーターの重複を排除しつつ昇順にソート
buildings = buildings.map { elevators in
  var nex = [Elevator]()
  for elevator in elevators.sorted() {
    if nex.isEmpty || nex.last!.hi < elevator.lo {
      nex.append(elevator)
    } else {
      let last = nex.popLast()!
      nex.append(Elevator(lo: last.lo, hi: max(last.hi, elevator.hi)))
    }
  }
  return nex
}

// 全エレベーターの一番下、一番上、乗り降り階をまとめてイベント列とキーを作る
enum Pos: Comparable {
  case lo
  case hi
  case mid
}

struct Event: Comparable {
  var lo: Int
  var pos: Pos
  var hi: Int

  static func < (a: Event, b: Event) -> Bool {
    if a.lo == b.lo {
      if a.pos == b.pos {
        return a.hi < b.hi
      } else {
        return a.pos < b.pos
      }
    } else {
      return a.lo < b.lo
    }
  }
}
var keys = [Int]()
var events = [Event]()

for elevator in buildings.joined() {
  keys.append(elevator.lo)
  keys.append(elevator.hi)
  events.append(Event(lo: elevator.lo, pos: .lo, hi: elevator.hi))
  events.append(Event(lo: elevator.hi, pos: .hi, hi: -1))
}

// クエリを先読みして、キーに乗り降り階を含めておく
let queries: [(Int,Int,Int,Int)] = (0..<q).map { _ in
  let (x, y, z, w) = get4()
  keys.append(y)
  keys.append(w)
  events.append(Event(lo: y, pos: .mid, hi: -1))
  events.append(Event(lo: w, pos: .mid, hi: -1))
  return (x, y, z, w)
}

// イベント列をソート
events.sort()

// 座標圧縮
let cc = CC(keys: keys)

// dpテーブルを埋める
// dp[keyのi番目にいるとき][あと2**j回で] := たどり着けるkeyのindex
// (1) j = 0を最初に求めて、(2) あとはダブリング

// dpテーブルの初期化
var dp = [[Int]](
  repeating: [Int](
    repeating: 0,
    count: 20
  ),
  count: cc.count
)

// (1) j=0の場合
var maxi = 0
for event in events {
  if event.pos == .lo {
    maxi = max(maxi, event.hi)
  } else if event.pos == .mid {
    maxi = max(maxi, event.lo)
  }

  let nex = max(event.lo, maxi)
  dp[cc.index(event.lo)][0] = cc.index(nex)
}

// (2) ダブリング
for j in 1..<20 {
  for i in 0..<cc.count {
    dp[i][j] = dp[dp[i][j-1]][j-1]
  }
}

func bsearch(_ evs: [Elevator], x: Int) -> Elevator? {
  if evs.isEmpty || evs.last!.hi < x {
    return nil
  }

  if !evs.isEmpty && evs.first!.hi >= x {
    return evs.first!
  }

  var lo = 0
  var hi = evs.count
  while (hi - lo) > 1 {
    let mid = (lo + hi) / 2
    if evs[mid].hi >= x {
      hi = mid
    } else {
      lo = mid
    }
  }
  return evs[hi]
}

// dpテーブルを利用してクエリに答える
for query in queries {
  var (x, y, z, w) = query
  if y > w {
    (x, y, z, w) = (z, w, x, y)
  }

  x -= 1
  z -= 1
  var ans = w - y

  // ビルx内でyから一番上まで移動
  if let elevator = bsearch(buildings[x], x: y) {
    if elevator.lo <= y {
      y = elevator.hi
    }
  }

  // ビルzのw階から一番下まで移動
  if let elevator = bsearch(buildings[z], x: w) {
    if elevator.lo <= w {
      w = elevator.lo
    }
  }

  // コーナーケース
  if y >= w {
    if x != z {
      print(ans + 1)
    } else {
      print(ans)
    }
    continue
  }

  y = cc.index(y)
  w = cc.index(w)

  // 2^19回移動してもゴール未満であれば答えなし
  if dp[y].last! < w {
    print(-1)
    continue
  }

  while y < w {
    // １回の移動でゴールするなら答え
    if dp[y][0] >= w {
      print(ans + 2)
      break
    }

    // そうでなければギリギリまで近づく
    for j in 0..<20 {
      if w <= dp[y][j] {
        ans += (1 << (j - 1))
        y = dp[y][j-1]
        break
      }
    }
  }
}
