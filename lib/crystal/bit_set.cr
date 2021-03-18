# 集合のbit表現ためのInt拡張
struct Int
  # 割り切る
  #
  # ```
  # 3.div?(12) # => true
  # 3.div?(7)  # => false
  # ```
  def div?(b)
    b.divisible_by?(self)
  end

  # 部分集合の列挙（空集合除く）
  #
  # ```
  # 3.subsets.map(&.to_bit(2)).to_a # => ["11","10","01"]
  # ```
  def subsets
    SubsetIterator.new(self)
  end

  # 真部分集合の列挙（空集合除く）
  #
  # ```
  # 3.proper_subsets.map(&.to_bit(2)).to_a # => ["11","10","01"]
  # ```
  def proper_subsets
    ProperSubsetIterator.new(self)
  end

  # 指定サイズの部分集合の辞書順列挙
  #
  # ```
  # 3.fix_size_subsets(2).map(&.to_bit(2)).to_a #=> ["011","101","110"]
  # ```
  def fix_size_subsets(k)
    FixSizeSubsetIterator.new(to_i64, k.to_i64)
  end

  # 集合の要素の列挙
  #
  # ```
  # 10.bit_elements.to_a # => [1, 3]
  # ```
  def bit_elements
    BitElementIterator.new(self)
  end

  # 省略名
  def bits
    bit_elements
  end

  # ゼロ埋め*n*桁指定での２進数表記
  #
  # ```
  # 10.to_bit(4) # => "1010"
  # ```
  def to_bit(n)
    "%0#{n}b" % self
  end

  # ゼロ埋め*n*桁での補集合（反転）
  #
  # ```
  # 10.inv(4).to_bit(4) # => "0101"
  # ```
  def inv(n)
    self ^ ((1_i64 << n) - 1)
  end

  # atの逆
  #
  # ```
  # 1.of([4, 7, 1]) # => 7
  # ```
  def of(a)
    a[self]
  end

  def on(k)
    to_i64 | (1 << k)
  end

  def off(k)
    to_i64 & ~(1 << k)
  end

  def lsb
    self & -self
  end

  def msb
    Math.ilogb(self)
  end

  def div_ceil(b)
    (self + b - 1) // b
  end

  def exp2
    1_i64 << self
  end

  # 部分集合の列挙
  #
  # ```
  # SubsetIterator.new(3).map(&.to_bit(2)).to_a # => ["11","10","01"]
  # ```
  private class SubsetIterator
    include Iterator(Int64)
    getter v : Int64
    getter b : Int64

    def initialize(v)
      @v = v.to_i64
      @b = @v
    end

    def next
      if b > 0
        begin b ensure @b = (b - 1) & v end
      else
        stop
      end
    end
  end

  # 真部分集合の列挙
  #
  # ```
  # ProperSubsetIterator.new(3).map(&.to_bit(2)).to_a # => ["11","10","01"]
  # ```
  private class ProperSubsetIterator
    include Iterator(Int64)
    getter v : Int64
    getter b : Int64

    def initialize(v)
      @v = v.to_i64
      @b = @v
    end

    def next
      @b = (b - 1) & v
      if b > 0
        b
      else
        stop
      end
    end
  end

  # サイズKの部分集合の列挙
  #
  # ```
  # FixSizeSubsetIterator.new(3, 2).map(&.to_bit(3)).to_a # => ["011","101","110"]
  # ```
  private class FixSizeSubsetIterator
    include Iterator(Int64)
    getter n : Int64
    getter k : Int64
    getter b : Int64

    def initialize(@n, @k)
      @b = (1_i64 << k) - 1
    end

    def next
      if b < (1 << n)
        begin
          b
        ensure
          x = b & -b
          y = b + x
          @b = ((b & ~y) // x >> 1) | y
        end
      else
        stop
      end
    end
  end

  # 集合の要素の列挙
  #
  # ```
  # BitElementIterator.new(10).to_a # => [1, 3]
  # ```
  private class BitElementIterator
    include Iterator(Int32)
    getter v : Int64
    getter i : Int32

    def initialize(v)
      @v = v.to_i64
      @i = 0
    end

    def next
      while (1_i64 << i) <= v && v.bit(i) == 0
        @i += 1
      end
      if (1_i64 << i) > v
        stop
      else
        begin i ensure @i += 1 end
      end
    end
  end
end

class BitSet(N)

  # ブロックの評価値で初期化
  #
  # ```
  # BitSet(3).make(&.odd) # => 0b010
  # ```
  def self.make(&f : Int32 -> Bool) : Int64
    v = 0_i64
    N.times do |i|
      next unless f.call(i)
      v |= 1_i64 << i
    end
    return v
  end

  # 真偽値の配列で初期化
  #
  # ```
  # BitSet(3).make([true, false, false]) # => 0b001
  # ```
  def self.make(a : Array(Bool)) : Int64
    make { |i| a[i] }
  end

  # グラフの隣接リスト(0-indexed)から初期化
  # ```
  # BitSet(3).make([1,2]) # => 0b110
  # ```
  def self.make(a : Array(Int32)) : Int64
    v = 0_i64
    a.each do |i|
      v |= 1_i64 << i
    end
    return v
  end
end
