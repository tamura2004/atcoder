struct IceCream: Equatable, Comparable {
  var id: Int
  var flabor: Int
  var satisfy: Int

  static func < (a: IceCream, b: IceCream) -> Bool {
    if a.satisfy == b.satisfy {
      if a.flabor == b.flabor {
        return a.id < b.id
      } else {
        return a.flabor < b.flabor
      }
    } else {
      return a.satisfy < b.satisfy
    }
  }
}

let n = Int(readLine()!)!
let iceCreams : [IceCream] = (0..<n).map { id in
  let line = readLine()!.split(separator: " ").map { Int($0)! }
  let flabor = line[0]
  let satisfy = line[1]
  return IceCream(id: id, flabor: flabor, satisfy: satisfy)
}

let bestIceCream = iceCreams.max()!

var ans = 0
for iceCream in iceCreams {
  if bestIceCream.id == iceCream.id {
    continue
  } else if bestIceCream.flabor == iceCream.flabor {
    ans = max(ans, bestIceCream.satisfy + iceCream.satisfy / 2)
  } else {
    ans = max(ans, bestIceCream.satisfy + iceCream.satisfy)
  }
}

print(ans)