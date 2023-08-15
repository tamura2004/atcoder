let n = Int(readLine()!)!

struct Player {
  let id:Int
  let num:Int
  let bet:[Int]
}

var players = [Player]()
for i in 0..<n {
  let c = Int(readLine()!)!
  let a = readLine()!.split(separator: " ").map { Int($0)! }
  players.append(
    Player(id: i, num: c, bet: a)
  )
}

let x = Int(readLine()!)!

let winner = players.filter {
  $0.bet.contains(x)
}

if winner.isEmpty {
  print(0)
} else {
  let mini = winner.map{$0.num}.min()
  let ans = winner.filter {
    $0.num == mini
  }.map {
    String($0.id + 1)
  } 
  print(ans.count)
  print(ans.joined(separator: " "))
}
