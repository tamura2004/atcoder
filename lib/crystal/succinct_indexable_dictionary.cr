# 完備辞書
class SuccinctIndexableDictionary
  getter length : UInt32
  getter blocks : UInt32
  getter bit : Array(UInt32)
  getter sum : Array(UInt32)

  def initialize(length)
    @length = length.to_u32
    @blocks = (@length + 31) >> 5
    @bit = Array.new(blocks, 0u32)
    @sum = Array.new(blocks, 0u32)
  end

  # k番目の要素を1にする
  def set(k : Int32)
    bit[k >> 5] |= 1u32 << (k & 31)
  end

  # 前計算
  def build
    sum[0] = 0u32
    (1...blocks).each do |i|
      sum[i] = sum[i - 1] + bit[i - 1].popcount
    end
  end

  # k番目の要素を求める
  def [](k : Int) : Bool
    !((bit[k >> 5] >> (k & 31)) & 1).zero?
  end

  # [0, k)に含まれる1の数を求める
  def rank(k : Int) : Int
    x = bit[k >> 5] & ((1u32 << (k & 31)) - 1)
    (sum[k >> 5] + x.popcount).to_i32
  end
  
  # [0, k)に含まれるvalの数を求める
  def rank(val : Bool, k : Int) : Int
    val ? rank(k) : k - rank(k)
  end

  # k番目に現れる1の位置を求める
  def select(k : Int)
    (0..length).bsearch { |i| k <= rank(i) }.try(&.pred)
  end

  # k番目に現れるvalの位置を求める
  def select(val : Bool, k : Int)
    (0..length).bsearch { |i| k <= rank(val, i) }.try(&.pred)
  end
end

alias SID = SuccinctIndexableDictionary
