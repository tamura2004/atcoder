MOD = 10_i64 ** 9 + 7

# MODを法とした階乗、組み合わせ
class ModCombination
  property :mod, :fac, :inv, :finv

  def initialize(n : Int64, mod : Int64 = MOD)
    @mod = mod
    @fac = Array(Int64).new(n+1, 1)
    @inv = Array(Int64).new(n+1, 1)
    @finv = Array(Int64).new(n+1, 1)

    (2..n).each do |i|
      fac[i] = fac[i - 1] * i % mod
      inv[i] = mod - inv[mod % i] * (mod // i) % mod
      finv[i] = finv[i - 1] * inv[i] % mod
    end
  end

  def combination(n, k)
    return 0 if n < k
    return 0 if n < 0 || k < 0

    fac[n] * (finv[k] * finv[n - k] % mod) % mod
  end

  def repeated_combination(n, k)
    combination(n + k - 1, k)
  end
end

##########################
# Example

MC = ModCombination.new(1_000_000)
ans = MC.combination(1_000_000, 800)
puts ans
# 686051302

# MODを法としたxのy乗を求める（繰り返し二乗法）
def modPow(x,y)
  ans = 1
  while y > 0
    ans = ans * x % MOD if y & 1 == 1
    y /= 2
    x = x * x % MOD
  end
  return ans
end
