# コンビネーション
def combination(n,k)
  ans = 1_i64
  (1..k).each do |i|
    ans *= (n + 1 - i)
    ans //= i
  end
  ans
end

def repeated_combination(n,k)
  combination(n+k-1,k)
end

# 任意modのコンビネーション表を
# 二項定理に基づき作成する
#
# combi
# 1 0 0 0
# 1 1 0 0
# 1 2 1 0 ...
class CombinationFactory
  getter n : Int64
  getter mod : Int64
  getter combi : Array(Array(Int64))

  def initialize(n, mod)
    @n = n.to_i64
    @mod = mod.to_i64
    @combi = Array.new(n+1) do
      Array.new(n+1, 0_i64)
    end
    (n+1).times do |i|
      combi[i][0] = 1_i64
    end

    (1..n).each do |y|
      (1..n).each do |x|
        combi[y][x] = (combi[y-1][x-1] + combi[y-1][x]) % mod
      end
    end
  end

  def create
    combi
  end

  def c(n,k)
    combi[n][k]
  end
end

# 2の冪のテーブルを任意modで作成する
class Pow2Factory
  getter n : Int64
  getter mod : Int64
  getter pw2 : Array(Int64)

  def initialize(n, mod)
    @n = n.to_i64
    @mod = mod.to_i64
    @pw2 = Array.new(n+1, 0_i64)
    pw2[0] = 1_i64

    (1..n).each do |i|
      pw2[i] = (pw2[i-1] * 2_i64) % mod
    end
  end

  def create
    pw2
  end
end
