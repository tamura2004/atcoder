let ab = readLine()!.split(separator: " ").map { Int(String($0))! }
let a = ab[0]
let b = ab[1]
let ans = a + 1 == b && a % 3 != 0 ? "Yes" : "No"
print(ans)
