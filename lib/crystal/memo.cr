# メモ化再帰
#
# 継承して使用。継承先でメソッド*g*を定義する。
# 再帰呼び出しは*f*を呼ぶ。
# 最初の呼び出しはクラスメソッドの[]
# ```
# # 例：フィボナッチ数列
# class Fibonacchi < Memo(Int32, Int32)
#   def g(m, n)
#     return n + 1 if m == 0
#     return f(m - 1, 1) if n == 0
#     f(m - 1, f(m, n - 1))
#   end
# end
# Fibonacchi[6] # => 8
# ```
class Memo(K,V)
  getter memo : Hash(K,V?)

  def self.[](k : K)
    new.f(k)
  end

  def initialize
    @memo = Hash(K,V?).new(nil)
  end

  def f(*key : *K) : V
    memo[key] ||= g(*key)
  end

  def f(key : K) : V
    memo[key] ||= g(key)
  end
end

macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

class Problem
  getter n : Int32
  getter a : Array(Int64)
  getter dp : Array(Array(Int64?))
  INF = Int64::MAX//4

  def initialize
    @n = gets.to_s.to_i
    @a = gets.to_s.split.map(&.to_i64)
    @dp = Array.new(n*2) { Array.new(n*2) { nil.as(Int64?) } }
  end

  def solve(i, j)
    dp[i][j] ||= _solve(i,j)
  end

  def _solve(i, j)
    case
    when (j - i).even?
      INF
    when j - i == 1
      dist(i, j)
    else
      cnt = dist(i, j) + solve(i+1, j-1)
      (i+1).upto(j-2) do |k|
        chmin cnt, solve(i,k) + solve(k+1,j)
      end
      cnt
    end
  end

  private def dist(i, j)
    (a[i] - a[j]).abs
  end

  def show
    pp solve(0,n*2-1)
  end
end

Problem.new.show
