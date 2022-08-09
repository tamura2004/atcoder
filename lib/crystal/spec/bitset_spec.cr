require "spec"
require "crystal//bitset"

describe Bitset do
  it "usage" do
    bs = Bitset.new(10)
    bs.set(0)
    bs.set(3)
    bs.to_s.should eq "0000001001"
  end

  it "long" do
    bs = Bitset.new(200)
    bs.set(0)
    bs.set(3)
    bs.to_s.should eq "0" * 196 + "1001"
  end

  it "shift or" do
    bs = Bitset.new(10)
    bs.set(0)
    bs.shift_or!(2)
    bs.shift_or!(4)
    bs.to_s.should eq "0001010101"
  end

  it "long shift or" do
    bs = Bitset.new(1000)
    bs.set(0)
    bs.shift_or!(200)
    bs.shift_or!(300)
    bs.to_s.should eq "0" * 499 + "1" + "0" * 199 + "1" + "0" * 99 + "1" + "0" * 199 + "1"
    bs.popcount.should eq 4
  end
end
