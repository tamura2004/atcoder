MOD = 10 ** 9 + 7

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
class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)

  def initialize
    @n,@d=gets.split.map(&:to_i)
    @x,@y=gets.split.map { |v| v.to_i.abs }
  end

  def solve
    return 0 if x % d != 0 || y % d != 0
    @x /= d
    @y /= d
    return 0 if n < x + y
    
    ft = FactTable.new(x + y)
    k = n - x - y
    if k.odd?
      return 0
    else
      pp [x,y,ft.nCk(x+y,x),n,k]
      # ans = ft.nCk(x+y,x).to_f

      return 0.25 ** (x + y + k / 2) * ft.nCk(x+y,x)
    end
  end

  def show(ans)
    puts ans
  end
end

Problem.new.instance_eval do
  show(solve)
end