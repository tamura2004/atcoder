import Foundation

let n = Int(readLine()!)!
let s = Array(readLine()!)
var seen = 0

for i in 0 ..< n {
  seen |= s[i] == "A" ? 1 : s[i] == "B" ? 2 : 4
  if seen == 7 {
    print(i + 1)
    exit(0)
  }
}