import sequtils,strutils,math,algorithm,tables,sets

let get = iterator: string {.closure.} =
  for s in stdin.readAll.split: yield s
proc read: int = get().parseInt
template rep(p: untyped, n: int): seq = newSeqWith(n,p)
template `%=`(a, b: untyped) = a = a mod b
template chmin(a, b: untyped) =
  if a > b: a = b

const MOD = 1_000_000_007i64
let s = get().mapIt(parseInt($it))
let n = s.len
let d = read()
var dp = 0i64.rep(d).rep(2).rep(n+1)
dp[0][0][0] = 1

for i in 0..<n:
  for less in 0..1:
    for j in 0..<d:
      for k in 0..9:
        if less == 0 and k > s[i]: continue

        var nextLess = less
        if k < s[i]: nextLess = 1
        
        let nextJ = (j + k) mod d
        dp[i+1][nextLess][nextJ] += dp[i][less][j]
        dp[i+1][nextLess][nextJ] %= MOD

var ans = dp[n][0][0]
ans += dp[n][1][0]
ans %= MOD
ans += MOD - 1i64
ans %= MOD
echo ans
