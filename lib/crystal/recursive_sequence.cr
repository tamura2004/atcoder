# 再帰関数により定義される数列の事前生成
#
# ```
# n = 10
# init = [1, 1]
# f = Proc(Array(Int32), Int32).new do |a|
#   a[-1] + a[-2]
# end
# fib = RS(Int32).new(n, init, f).create
# fib.should eq [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
# ```
class RecursiveSequence(T)
  getter n : Int32
  getter create : Array(T)
  delegate "[]", to: create

  def initialize(n : Int, @create : Array(T))
    @n = n.to_i
    while create.size <= n
      create << yield create
    end
  end
end
