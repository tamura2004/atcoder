require "crystal/cc"
require "crystal/st"

# 転倒数を求める
# 値域が大きい場合に備えて圧縮
class InversionNumber(T)
  getter a : Array(Int32)

  def initialize(a : Array(T))
    @a = a.compress
  end

  def solve
    st = a.size.succ.to_st_sum
    ans = 0_i64
    a.each do |v|
      ans += st[v.succ..]
      st[v] += 1_i64
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
