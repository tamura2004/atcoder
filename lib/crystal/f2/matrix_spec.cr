require "spec"
require "crystal/f2/matrix"
require "crystal/bitset"
include F2

describe F2::Matrix do
  it "usage" do
    m = Matrix(Int32).new(4)
    m << 0b1101
    m << 0b0111
    m << 0b1011
    m << 0b1001
    m << 0b0001
    m.solve
    m.rank.should eq 4
  end

  it "with bitset" do
    m = Matrix(Bitset).new(9)
    m << Bitset.new("110000001")
    m << Bitset.new("011000101")
    m << Bitset.new("101000100")
    m.solve
    m.rank.should eq 2
  end
    
end
