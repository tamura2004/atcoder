# ans = 4^0 + 4^1 + ... + 4^n　とする
# ans * 4 - ans = 4^(n+1) - 4^0
# ans = (4^(n+1) - 1) // 3

require "crystal/mod_int"

n = gets.to_s.to_i64
ans = ((4.to_m ** (n + 1)) - 1) // 3
pp ans
