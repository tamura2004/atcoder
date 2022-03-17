# メモ化再帰
#
# 継承して使用。継承先でメソッド*g*を定義する。
# 再帰呼び出しは*f*を呼ぶ。
# 最初の呼び出しはクラスメソッドの[]
# ```
# # 例：フィボナッチ数列(1引数)
# class Fibonacchi < Memo(Int32, Int32)
#   def g(m, n)
#     return n + 1 if m == 0
#     return f(m - 1, 1) if n == 0
#     f(m - 1, f(m, n - 1))
#   end
# end
# Fibonacchi[6] # => 8
#
# # 例：アッカーマン関数（2引数）
# class Ackermann < Memo(Tuple(Int32, Int32), Int32)
#   def g(m, n)
#     return n + 1 if m == 0
#     return f(m - 1, 1) if n == 0
#     f(m - 1, f(m, n - 1))
#   end
# end
# Ackermann[3, 3] # => 61
# ```
class Memo(K,V)
  getter memo : Hash(K,V?)

  def self.[](k : K)
    new.f(k)
  end

  def self.[](*k : *K)
    new.f(*k)
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
