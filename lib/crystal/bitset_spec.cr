require "spec"
require "crystal/bitset"

describe Bitset do
  it "usage" do
    bs = [0, 3].to_bitset(maxi: 10)
    bs.to_s.should eq "0000001001"
  end

  it "long" do
    bs = [0, 199].to_bitset(maxi: 200)
    bs.to_s.should eq "1" + "0" * 198 + "1"
  end

  it "get" do
    bs = [0, 1000, 2000].to_bitset(3000)
    bs.get(0).should eq 1
    bs.get(1).should eq 0
    bs.get(999).should eq 0
    bs.get(1000).should eq 1
    bs.get(2000).should eq 1
  end

  it "shift or" do
    bs = [0].to_bitset(10)
    bs.shift_or!(2)
    bs.shift_or!(4)
    bs.to_s.should eq "0001010101"
  end

  it "shift_left!" do
    bs = [0, 3].to_bitset(1000)
    bs.shift_left!(996)
    bs.to_s.should eq "1001" + "0" * 996
  end

  it "shift_right!" do
    bs = [999, 996].to_bitset(1000)
    bs.shift_right!(996)
    bs.to_s.should eq "0" * 996 + "1001"
  end

  it "or" do
    a = [1, 3].to_bitset(10)
    b = [3, 5].to_bitset(10)
    a.or!(b)
    a.to_s.should eq "0000101010"
  end

  it "and" do
    a = [1, 3].to_bitset(10)
    b = [3, 5].to_bitset(10)
    a.and!(b)
    a.to_s.should eq "0000001000"
  end

  it "xor" do
    a = [1, 3].to_bitset(10)
    b = [3, 5].to_bitset(10)
    a.xor!(b)
    a.to_s.should eq "0000100010"
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
