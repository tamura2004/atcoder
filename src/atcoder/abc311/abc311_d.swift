class Queue<T> {
  let capacity: Int
  private var buffer: [T?]
  private var lo = 0
  private var hi = -1

  public var count: Int {
    return (hi - lo + 1)
  }

  public init(capacity: Int) {
    self.capacity = capacity
    self.buffer = [T?](repeating: nil, count: capacity)
  }

  public func push(_ value: T) {
    hi += 1
    hi %= capacity
    buffer[hi] = value
  }

  public func shift() -> T? {
    let value = buffer[lo % capacity]
    lo += 1
    lo %= capacity
    return value
  }
}

enum State {
  case Up
  case Down
  case Left
  case Right
  case Stop
}

let line = readLine()!.split(separator: " ").map { Int($0)! }
let h = line[0]
let w = line[1]
var s = (0..<h).map { _ in [Character](readLine()!) }

var seen = (0..<h).map { _ in (0..<w).map { _ in Set<State>() }}
seen[1][1].insert(.Stop)

typealias Position = (Int, Int, State)

var q = Queue<Position>(capacity: h * w * 5)
q.push((1, 1, .Stop))

while q.count > 0 {
  let (y, x, dir) = q.shift()!

  for (dy, dx, ndir): Position in [
    (-1, 0, .Up),
    (1, 0, .Down),
    (0, 1, .Right),
    (0, -1, .Left)
  ] {
    if dir != .Stop && dir != ndir { continue }

    let ny = y + dy
    let nx = x + dx

    if s[ny][nx] == "#" {
      if dir != .Stop { q.push((y, x, .Stop)) }
      continue
    }

    if seen[ny][nx].contains(ndir) { continue }
    seen[ny][nx].insert(ndir)

    q.push((ny,nx,ndir))
  }
}

var ans = (0..<h).map { seen[$0].filter { !$0.isEmpty }.count }.reduce(0, +)
print(ans)
