MOD = 10 ** 9 + 7

######################################################
# ruby 2.3
######################################################
class FacTable
  attr_accessor :fa,:iv,:fi
  def initialize(n)
    @fa = Array.new(n+1,1)
    @iv = Array.new(n+1,1)
    @fi = Array.new(n+1,1)
    2.upto(n) do |i|
      @fa[i] = fa[i-1] * i % MOD
      @iv[i] = MOD - iv[MOD % i] * (MOD / i) % MOD
      @fi[i] = fi[i-1] * iv[i] % MOD
    end
  end
  def nCk(n,k)
    return 0 if n < k || n < 0 || k < 0
    fa[n] * fi[k] * fi[n-k] % MOD
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


######################################################
# ruby 2.5.1 or later
######################################################
module ModInt
  MOD = 10 ** 9 + 7

  def to_mod(a); a % MOD; end
  def add(a, b); (a + b) % MOD; end
  def mul(a, b); (a * b) % MOD; end
  def inv(a); a.pow(MOD - 2, MOD); end
  def div(a, b); mul(a, inv(b)); end
end

class FactTable
  include ModInt

  def initialize(n)
    @fact = [1] * (n + 1)
    @finv = [1] * (n + 1)
    2.upto(n) { |i| @fact[i] = mul(@fact[i - 1], i) }
    @finv[n] = inv(@fact[n])
    n.downto(3) { |i| @finv[i - 1] = mul(@finv[i], i) }
  end

  def nCk(n, m)
    mul(mul(@fact[n], @finv[m]), @finv[n - m])
  end
end

# assert nCk(200000,100000) == 87946733