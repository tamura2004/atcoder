let lr = readLine()!.split(separator: " ").map { Int($0)! }
let l = lr[0] - 1
let r = lr[1] - 1
let s = "atcoder".split(separator: "")
print(s[l...r].joined())
