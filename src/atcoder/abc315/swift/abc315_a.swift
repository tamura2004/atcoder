import Foundation

let s = readLine()!
let ans = s.replacingOccurrences(
  of: "[aiueo]",
  with: "",
  options: .regularExpression,
  range: nil
)
print(ans)