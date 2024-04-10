require "spec"
require "crystal/bitset"

describe Bitset do
  it "usage" do
    bs = [0, 1000].to_bitset
    bs.set(500)
    bs.to_a.should eq [0, 500, 1000]
  end

  it "array to bitset with offset" do
    bs = [-1000, 0, 1000].to_bitset(maxi: 2001, offset: 1000)
    bs.to_a.should eq [0, 1000, 2000]
    bs.to_a(offset: 1000).should eq [-1000, 0, 1000]
  end

  it "get" do
    bs = [0, 1000, 2000].to_bitset
    bs.get(0).should eq 1
    bs.get(1).should eq 0
    bs.get(999).should eq 0
    bs.get(1000).should eq 1
    bs.get(2000).should eq 1
  end

  it "shift_or!" do
    bs = [0].to_bitset(2000)
    bs.shift_or!(1000)
    bs.shift_or!(1000)
    bs.to_a.should eq [0, 1000, 2000]
  end

  it "shift_left!" do
    bs = [0, 1000].to_bitset(2000)
    bs.shift_left!(1000)
    bs.to_a.should eq [1000, 2000]
  end

  it "<<" do
    a = [0, 1000].to_bitset(2000)
    b = a << 1000
    a.to_a.should eq [0, 1000]
    b.to_a.should eq [1000, 2000]
  end

  it "shift_right!" do
    bs = [1000, 2000].to_bitset
    bs.shift_right!(1000)
    bs.to_a.should eq [0, 1000]
  end

  it ">>" do
    a = [1000, 2000].to_bitset
    b = a >> 1000
    a.to_a.should eq [1000, 2000]
    b.to_a.should eq [0, 1000]
  end

  it "or!" do
    a = [1000, 2000].to_bitset
    b = [0, 1000].to_bitset
    a.or!(b)
    a.to_a.should eq [0, 1000, 2000]
  end

  it "|" do
    a = [1000, 2000].to_bitset
    b = a | [0, 1000].to_bitset
    a.to_a.should eq [1000, 2000]
    b.to_a.should eq [0, 1000, 2000]
  end

  it "and!" do
    a = [1000, 2000].to_bitset
    b = [0, 1000].to_bitset
    a.and!(b)
    a.to_a.should eq [1000]
  end

  it "&" do
    a = [1000, 2000].to_bitset
    b = a & [0, 1000].to_bitset
    a.to_a.should eq [1000, 2000]
    b.to_a.should eq [1000]
  end

  it "xor!" do
    a = [1000, 2000].to_bitset
    b = [0, 1000].to_bitset
    a.xor!(b)
    a.to_a.should eq [0, 2000]
  end

  it "^" do
    a = [1000, 2000].to_bitset
    b = a ^ [0, 1000].to_bitset
    a.to_a.should eq [1000, 2000]
    b.to_a.should eq [0, 2000]
  end

  it "not!" do
    a = [3, 5].to_bitset
    a.not!
    a.to_a.should eq [0, 1, 2, 4]
  end

  it "~" do
    a = [3, 5].to_bitset
    b = ~a
    a.to_a.should eq [3, 5]
    b.to_a.should eq [0, 1, 2, 4]
  end
end
