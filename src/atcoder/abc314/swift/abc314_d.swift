func get1() -> Int {
  return Int(readLine()!)!
}

struct Query {
  let t:Int
  let x:Int
  let c:Character
}

let n = get1()
var s = Array(readLine()!)
let q = get1()
let qs = (0..<q).map { _ -> Query in
  let line = readLine()!.split(separator: " ")
  return Query(
    t: Int(line[0])!,
    x: Int(line[1])! - 1,
    c: Array(line[2])[0]
  )
}

var used = false
let filtered_qs = qs.reversed().filter {
  if $0.t == 1 { return true }
  if used { return false }
  used = true
  return true
}

for query in filtered_qs.reversed() {
  if query.t == 1 {
    s[query.x] = query.c
  } else if query.t == 2 {
    s = Array(String(s).lowercased())
  } else {
    s = Array(String(s).uppercased())
  }
}
print(String(s))
