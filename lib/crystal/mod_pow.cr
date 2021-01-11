# MODを法としてxのy乗を求める（繰り返し二乗法）
#
# ```
# n = 10_i64
# m = 10_i64 ** 18
# mod = 10_i64 ** 9 + 7
# mod_pow(n, m, mod) # => 2401
# ```
def mod_pow(x, y, mod)
  ans = 1_i64
  while y > 0
    ans = (ans * x) % mod if y.bit(0) == 1
    y //= 2
    x = (x * x) % mod
  end
  return ans
end
