struct Bitset
  DIGIT = 128

  getter n : Int32
  getter a : Array(UInt128)

  def initialize(@size = 128)
    @n = (size + DIGIT - 1) // DIGIT
    @a = Array.new(n, 0_u128)
  end
  
  def initialize(@a : Array(UInt128))
    @n = a.size
    @size = n * DIGIT
  end
  
  def initialize(s : String, @size = 128)
    @n = (size + DIGIT - 1) // DIGIT
    @a = Array.new(n, 0_u128)
    s.chars.each_with_index do |c, i|
      if c == '1'
        set(i)
      end
    end
  end

  def self.zero
    Bitset.new
  end

  def set(i)
    j, k = i.divmod(DIGIT)
    a[j] |= 1_u128 << k
  end
  
  def bit(i)
    j, k = i.divmod(DIGIT)
    a[j].bit(k)
  end

  def |(b : self)
    Bitset.new a.zip(b.a).map { |i,j| i | j }
  end
  
  def &(b : self)
    Bitset.new a.zip(b.a).map { |i,j| i & j }
  end
  
  def ^(b : self)
    Bitset.new a.zip(b.a).map { |i,j| i ^ j }
  end
  
  def zero?
    a.all?(&.zero?)
  end

  def popcount
    a.map(&.popcount).sum
  end

  def to_s
    a.map { |v| "%0#{DIGIT}b" % v }.join
  end
end
