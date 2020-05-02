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

require "forwardable"

class Modint
  extend Forwardable
  def_delegators :@a, :hash #, :to_i
  
  def initialize(a); @a = a.to_i % MOD; end
  def + (other); Modint[@a + other.to_i]; end
  def - (other); Modint[@a - other.to_i]; end
  def * (other); Modint[@a * other.to_i]; end
  def ** (other); Modint[@a.pow other.to_i, MOD]; end
  def / (other); Modint[@a * other.to_i.pow(MOD-2, MOD)]; end
  def eql? (other); @a.eql? other.to_i; end
  def to_i; @a.to_i; end
  def inspect; "#{@a}"; end
  def coerce(other); [self, other]; end
  
  alias :pow :**
  class << self; alias :[] :new; end
end
M = Modint

class Integer
  def to_m; Modint.new(self); end
end

10.times do |i|
  a = (100000*i).to_m ** (i*100000)
  puts a
end
