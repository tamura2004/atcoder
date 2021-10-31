require "spec"
require "crystal//bitset"

describe Bitset do
  it "usage" do
    bs = Bitset.new(200)
    bs.set(10)
    bs.set(13)
    bs.set(133)
    bs.popcount.should eq 3
  end

  it "op" do
    a = Bitset.new(200)
    a.set(1)
    a.set(3)
    a.set(10)
    b = Bitset.new(200)
    b.set(3)
    b.set(150)

    (a | b).popcount.should eq 4
    # (a & b).popcount.should eq 1
    # (a ^ b).popcount.should eq 3
  end
end
