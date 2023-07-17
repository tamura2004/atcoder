let xs = readLine()!.split(separator: " ").map { Int(String($0))! }
let (n, t, m) = (xs[0], xs[1], xs[2])
var dislike = (1...n).map { _ in Set<Int>() }

for _ in 0 ..< m {
  let ab = readLine()!.split(separator: " ").map { Int(String($0))! - 1 }
  let (a, b) = (ab[0], ab[1])
  dislike[a].insert(b)
  dislike[b].insert(a)
}

let pr = Problem(n, t, dislike)
print(pr.solve(0))

class Problem {
  var n: Int
  var t: Int
  var dislike: [Set<Int>]
  var state: [Set<Int>]

  init(_ n: Int, _ t: Int, _ dislike: [Set<Int>]) {
    self.n = n
    self.t = t
    self.dislike = dislike
    self.state = [Set<Int>]()
  }

  func solve(_ i: Int) -> Int {
    if t < state.count { return 0 }
    if i == n { return state.count == t ? 1 : 0 }

    var ans = 0
    state.append(Set([i]))
    ans += solve(i+1)
    let _ = state.popLast()

    if state.isEmpty { return ans }

    for j in 0 ..< state.count {
      if !dislike[i].isDisjoint(with: state[j]) { continue }
      state[j].insert(i)
      ans += solve(i+1)
      state[j].remove(i)
    }

    return ans
  }
}