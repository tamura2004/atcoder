# Bitsetを利用した行列表現
# グラフの隣接表現を想定（加算=or, 乗算=and)
class BitMatrix
  getter g : Array(Bitset)
  getter n : Int32
  delegate "[]", "[]=", "to_a", to: g

  def initialize(@n : Int32)
    @g = Array.new(n) { n.pred.to_bitset }
  end

  def initialize(@g : Array(Bitset))
    @n = g.size
  end

  def initialize(s : Array(String))
    @g = s.map(&.to_bitset)
    @n = s.size
  end

  def *(other : self)
    self.class.new(n).tap do |ans|
      n.times do |i|
        n.times do |j|
          next if g[i][j] == 0
          ans[i].or! other[j]
        end
      end
    end
  end
end

struct Bitset
  DIGIT = 128

  getter size : Int32
  getter n : Int32
  getter a : Array(UInt128)

  def initialize(size)
    @size = size.to_i + 1
    @n = (@size + DIGIT - 1) // DIGIT
    @a = Array.new(n, 0_u128)
  end

  def initialize(@size, @n, @a)
  end

  def dup
    Bitset.new(@size, @n, @a.dup)
  end

  def set(i, offset = 0)
    j, k = (i + offset).divmod(DIGIT)
    a[j] |= (1_u128 << k)
    self
  end

  def get(i, offset = 0)
    j, k = (i + offset).divmod(DIGIT)
    a[j].bit(k)
  end

  def [](i)
    get(i)
  end

  def set_at(arr)
    arr.each do |i|
      set(i)
    end
    self
  end

  # self = self | self << i
  def shift_or!(i)
    long, short = i.divmod(DIGIT)
    (0...n).reverse_each do |j|
      a[j] |= at(j - long) << short | at(j - long - 1) >> (DIGIT - short)
    end
    self
  end

  # self = self << i
  def shift_left!(i)
    long, short = i.divmod(DIGIT)
    (0...n).reverse_each do |j|
      a[j] = at(j - long) << short | at(j - long - 1) >> (DIGIT - short)
    end
    self
  end

  def <<(i)
    dup.shift_left!(i)
  end

  # self = self >> i
  def shift_right!(i)
    long, short = i.divmod(DIGIT)
    (0...n).each do |j|
      a[j] = at(j + long + 1) << (DIGIT - short) | at(j + long) >> short
    end
    self
  end

  def >>(i)
    dup.shift_right!(i)
  end

  # self = self | other
  def or!(other)
    (0...Math.min(n, other.n)).each do |j|
      a[j] |= other.at(j)
    end
    self
  end

  def |(other)
    dup.or!(other)
  end

  # self = self & other
  def and!(other)
    (0...Math.max(n, other.n)).each do |j|
      a[j] &= other.at(j)
    end
    self
  end

  def &(other)
    dup.and!(other)
  end

  # self = self ^ other
  def xor!(other)
    (0...Math.min(n, other.n)).each do |j|
      a[j] ^= other.at(j)
    end
    self
  end

  def ^(other)
    dup.xor!(other)
  end

  def not!
    (0...n).each do |j|
      a[j] = ~a[j]
    end
    self
  end

  def ~ : self
    dup.not!
  end

  def at(i)
    i.in?(0...n) ? a[i] : 0_u128
  end

  def popcount
    a.sum(&.popcount)
  end

  def to_s
    (0...size).map { |i| get(i) }.join
  end

  def to_a(offset = 0)
    (0...size).to_a.select { |i| get(i) == 1 }.map(&.- offset)
  end
end

struct Int
  def to_bitset
    Bitset.new(to_i)
  end
end

module Enumerable(T)
  def to_bitset
    to_bitset(max)
  end

  def to_bitset(maxi : Int, offset = 0)
    maxi.to_bitset.tap do |bs|
      each do |i|
        bs.set(i, offset)
      end
    end
  end
end

class String
  def to_bitset
    (0...size).select { |i| self[i] == '1' }.to_bitset(size)
  end
end
