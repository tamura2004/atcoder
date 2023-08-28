func getv() -> [Int] { readLine()!.split(separator: " ").map { Int($0)! } }
func get3() -> (Int, Int, Int) {
  let vs = getv()
  return (vs[0], vs[1], vs[2])
}

struct Potion {
  let id: Int
  let hp: Int
}

let (n, h, x) = get3()
let potions = zip(0..<n, getv()).map { (i, v) in Potion(id: i + 1, hp: v) }
let ans = potions.filter { x <= h + $0.hp }.first!

print(ans.id)