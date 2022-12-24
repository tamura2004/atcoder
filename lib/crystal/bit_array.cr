require "big"

# 多倍長整数を使用した集合管理
class BitArray
  Z = 0.to_big_i
  E = 1.to_big_i

  getter s : BigInt

  def initialize(@s = Z)
  end

  # 要素の追加
  def <<(e)
    @s |= E << e
  end

  # 要素の存在判定
  def includes?(e)
    s.bit(e) == 1
  end

  # 要素数
  def size
    s.popcount.to_i
  end

  # 和集合
  def +(other)
    BitArray.new(s | other.s)
  end
end

# 配列から集合へ
module Indexable(T)
  def to_bit_array
    BitArray.new.tap do |s|
      each do |e|
        s << e
      end
    end
  end
end

