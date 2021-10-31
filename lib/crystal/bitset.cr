struct Bitset
  getter n : Int32
  getter size : Int32
  getter a : Array(UInt64)

  def initialize(@size : Int32)
    @n = (size + 64 - 1) // 64
    @size = n * 64
    @a = Array.new(size, 0_u64)
  end

  def initialize(@a : Array(UInt64))
    @n = a.size
    @size = n * 64
  end

  def set(i)
    j, k = i.divmod(64)
    a[j] |= 1_u64 << k
  end

  def [](i)
    j, k = i.divmod(64)
    a[j].bit(k)
  end
  
  def |(b : self)
    Bitset.new a.zip(b.a).map { |i, j| i | j }
  end
  
  def &(b : self)
    Bitset.new a.zip(b.a).map { |i, j| i & j }
  end
  
  def ^(b : self)
    Bitset.new a.zip(b.a).map { |i, j| i ^ j }
  end

  def popcount
    a.map(&.popcount).sum
  end

  def to_s
    a.map { |v| "%0128b" % v }.join
  end
end
