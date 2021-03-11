require "spec"
require "../memo"

describe Memo do
  it "solve fibonacci" do
    Fibonacci.new.f(9).should eq 34
  end

  it "solve Ackermann function" do
    Ackermann.new.f(3, 3).should eq 61
  end
end

# フィボナッチ数列
class Fibonacci < Memo(Int32, Int32)
  def g(n)
    return 1 if n <= 2
    f(n - 1) + f(n - 2)
  end
end

# アッカーマン関数
class Ackermann < Memo(Tuple(Int32, Int32), Int32)
  def g(m, n)
    return n + 1 if m == 0
    return f(m - 1, 1) if n == 0
    f(m - 1, f(m, n - 1))
  end
end
