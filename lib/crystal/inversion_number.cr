require "crystal/coodinate_compress_segment_tree"

# 転倒数を求める
# 値域が大きい場合に備えて圧縮
class InversionNumber(T)
  getter a : Array(T)

  def initialize(@a : Array(T))
  end

  def solve
    st = a.to_ccst_sum
    ans = 0_i64
    a.each do |v|
      ans += st[v..]
      st[v] += 1
    end
    ans
  end
end

# 配列に対して転倒数を求める
class Array(T)
  def inversion_number
    InversionNumber(T).new(self).solve
  end

  def inv
    inversion_number
  end
end
