# 集合のbit表現
struct BitSet
  getter s : Int32

  def self.each(n)
    (1 << n).times do |s|
      yield BitSet.new(s)
    end
  end

  def initialize(@s = 0)
  end

  def includes?(e : Int)
    s.bit(e) == 1
  end

  def &(b : self)
    self.class.new(s & b.to_i)
  end

  def |(b : self)
    self.class.new(s | b.to_i)
  end

  def ^(b : self)
    self.class.new(s ^ b.to_i)
  end

  def to_set(e : Int)
    self.class.new(1 << e)
  end

  def +(e : Int)
    self | to_set(e)
  end

  def -(e : Int)
    self ^ to_set(e)
  end

  def size
    s.popcount
  end

  def to_i
    s
  end

  def each_subset
    SubsetIterator.new(to_i)
  end

  private class SubsetIterator
    include Iterator(BitSet)

    getter s : Int32
    getter t : Int32
    getter halt : Bool

    def initialize(@s)
      @t = s
      @halt = false
    end

    def next
      begin
        halt ? stop : BitSet.new(t)
      ensure
        @t = (t - 1) & s
        @halt = t == s
      end
    end
  end
end

