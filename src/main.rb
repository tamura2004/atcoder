MOD = 10 ** 9 + 7

# MODを法とした階乗、組み合わせ
class ModCombination
  attr_reader :fac, :inv, :finv, :mod
 
  def initialize(n, mod: MOD)
    @mod = mod
    @fac = [1, 1]
    @inv = [1, 1]
    @finv = [1, 1]
 
    (2..n).each do |i|
      @fac[i] = fac[i - 1] * i % mod
      @inv[i] = mod - inv[mod % i] * (mod / i) % mod
      @finv[i] = finv[i - 1] * inv[i] % mod
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

MC = ModCombination.new(300000)

# MODを法としたnCk、kが小さいとき
def nCk(n,k)
  ans = n
  2.upto(k) do |i|
    ans = ans * (n - i + 1) % MOD
    ans = ans * MC.inv[i] % MOD
  end
  ans
end

n,a,b = gets.split.map &:to_i
x = modPow(2,n)
y = MOD - nCk(n,a)
z = MOD - nCk(n,b)
puts (x + y + z - 1) % MOD
