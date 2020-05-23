# ruby 2.5以降
MOD = 10**9+7
module ModInt
  refine Integer do
    def +(b); (super b) % MOD; end
    def -(b); (super b) % MOD; end
    def *(b); (super b) % MOD; end
    def pow(b); super(b, MOD); end
    def /(b); self * b.pow(MOD - 2); end
  end
end
using ModInt

class FactTable
  attr_reader :fa, :fi
  def initialize(n)
    @fa = [1] * (n + 1)
    @fi = [1] * (n + 1)
    2.upto(n) { |i| fa[i] = fa[i - 1] * i }
    fi[n] = 1 / fa[n]
    n.downto(3) { |i| fi[i - 1] = fi[i] * i }
  end
 
  def nCk(n, m)
    fa[n] * fi[m] * fi[n - m]
  end
end

# usage
# n,m,k = gets.split.map(&:to_i)
# ft = FactTable.new(n)
 
# ans = 0
# 0.upto(k) do |k|
#   ans += (m-1).pow(n-1-k) * m * ft.nCk(n-1,k)
# end
# puts ans

