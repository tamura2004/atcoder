struct Bitset
  DIGIT = 128

  getter size : Int32
  getter n : Int32
  getter a : Array(UInt128)

  def initialize(size)
    @size = size.to_i
    @n = (@size + DIGIT - 1) // DIGIT
    @a = Array.new(n, 0_u128)
  end

  def initialize(@size, @n, @a)
  end

  def dup
    Bitset.new(@size, @n, @a)
  end

  def set(i)
    j, k = i.divmod(DIGIT)
    a[j] |= (1_u128 << k)
    self
  end

  def get(i)
    j, k = i.divmod(DIGIT)
    a[j].bit(k)
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
    (0...n).each do |j|
      a[j] |= other.a[j]
    end
    self
  end

  def |(other)
    dup.or!(other)
  end

  # self = self & other
  def and!(other)
    (0...n).each do |j|
      a[j] &= other.a[j]
    end
    self
  end

  def &(other)
    dup.and!(other)
  end

  # self = self ^ other
  def xor!(other)
    (0...n).each do |j|
      a[j] ^= other.a[j]
    end
    self
  end

  def ^(other)
    dup.xor!(other)
  end

  def at(i)
    a[i]? || 0_u128
  end

  def popcount
    a.sum(&.popcount)
  end

  def to_s
    a.reverse.map{|b| "%0#{DIGIT}b" % b}.join[-size,size]
  end
end

struct Int
  def to_bitset
    Bitset.new(self)
  end
end

module Enumerable(T)
  def to_bitset(maxi : T)
    bs = maxi.to_bitset
    each do |i|
      bs.set(i)
    end
    bs
  end
end
