MOD = 998244353
n, k, m = gets.split.map(&:to_i)
# if m % MOD == 0
#   pp 0
#   exit
# end

r = k.pow(n, MOD - 1)
ans = m.pow(r, MOD)
pp ans
