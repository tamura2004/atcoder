# 左右からの累積和を求める
#

class CumulativeSum(T)
  getter left : Array(T)
  getter right : Array(T)
  getter src : Array(T)
  getter n : Int32
  getter f : T, T -> T

  def initialize(src)
    initialize(src) { |a, b| a + b }
  end

  def initialize(@src, &@f : T, T -> T)
    @n = src.size
    @left = Array.new(n + 1) { T.zero }
    @right = Array.new(n + 1) { T.zero }
    n.times do |i|
      left[i + 1] = f.call left[i], src[i]
    end
    n.downto(1) do |i|
      right[i - 1] = f.call right[i], src[i - 1]
    end
  end

  # i番目の要素を除く
  def without(i)
  end

  delegate "[]", to: left
  delegate "[]=", to: left
end

alias CS = CumulativeSum(Int64)
