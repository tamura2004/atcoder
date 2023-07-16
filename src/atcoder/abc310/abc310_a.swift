let args = readLine()!.split(separator: " ").map { Int($0)! }
let n = args[0]
let p = args[1]
let q = args[2]
let d = readLine()!.split(separator: " ").map { Int($0)! }
let ans = min(p, q + d.min()!)
print(ans)
