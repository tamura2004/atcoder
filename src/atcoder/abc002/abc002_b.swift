let s = readLine()!
let ans = s.replacingOccurrences(
  of: "[aiueo]",
  with: "",
  options: .regularExpression
)
print(ans)