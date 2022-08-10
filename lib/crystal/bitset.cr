struct Bitset
  DIGIT = 128

  getter size : Int32
  getter n : Int32
  getter a : Array(UInt128)

  def initialize(@size)
    @n = (size + DIGIT - 1) // DIGIT
    @a = Array.new(n, 0_u128)
  end

  def set(i)
    j, k = i.divmod(DIGIT)
    a[j] |= 1 << k
  end

  # self = self | self << i
  def shift_or!(i)
    long, short = i.divmod(DIGIT)
    (0...n).reverse_each do |j|
      a[j] |= at(j - long) << short | at(j - long - 1) >> (DIGIT - short)
    end
  end

  # self = self << i
  def shift!(i)
    long, short = i.divmod(DIGIT)
    (0...n).reverse_each do |j|
      a[j] = at(j - long) << short | at(j - long - 1) >> (DIGIT - short)
    end
  end

  # self = self | other
  def or!(other)
    (0...n).each do |j|
      a[j] |= other.a[j]
    end
  end

  def at(i)
    i < 0 ? 0_u128 : a[i]
  end

  def popcount
    a.sum(&.popcount)
  end

  def to_s
    a.reverse.map{|b| "%0#{DIGIT}b" % b}.join[-size,size]
  end
end
