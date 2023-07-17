let n = Int(readLine()!)!
let a = Array(readLine()!)

var dp = [[Int]](repeating: [Int](repeating: 0, count: 2), count: n)

for i in 0 ..< n {
  if i == 0 {
    if a[i] == "0" {
      dp[i][0] += 1
    } else {
      dp[i][1] += 1
    }
  } else {
    if a[i] == "0" {
      dp[i][1] += i
      dp[i][0] += 1
    } else {
      dp[i][1] += 1
      dp[i][0] += dp[i - 1][1]
      dp[i][1] += dp[i - 1][0]
    }

  }
}
print(dp.reduce(0) { (acc, b) in acc + b[1]})