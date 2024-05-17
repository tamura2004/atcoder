require "spec"
require "crystal/segment_tree_beats"

record X, sum : Int64, cnt : Int64, fail : Bool do
  def initialize(@sum)
    @cnt = 1_i64
    @fail = false
  end

  def self.œzero
    X.new(0_i64, 0_i64, false)
  end

  def +(other : X) : X
    X.new(sum + other.sum, cnt + other.cnt, false)
  end

  def *(other : A) : X
    X.new(sum + cnt * other.v, cnt, false)
  end
end

record A, v : Int64 do
  def self.zero
    A.new(0_i64)
  end

  def +(other : A) : A
    A.new(v + other.v)
  end
end

class Array(T)
  def to_range_add_range_sum
    SegmentTreeBeats(X, A).new(map(&.to_i64))
  end
end

describe SegmentTreeBeats do
  it "usage" do
    values = [3, 1, 4, 1, 5]
    st = values.to_range_add_range_sum
    st[1..3] = 5 # => [3, 6, 9, 6, 5]
    st[..2].should eq 18
    st[..0] = -10 # => [-7, 6, 9, 6, 5]
    st[..1].should eq -1
    st[3..] = -20 # => [-7, 6, 9, -14, -15]
    st[0..].should eq -21
  end
end
