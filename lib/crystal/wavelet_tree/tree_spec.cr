require "spec"
require "crystal/wavelet_tree/tree"
include WaveletTree

describe Tree do
  it "usage" do
    t = Tree.new([0,7,2,1,4,3,6,7,2,5,0,4,7,2,6,3])
  end

  it "bit array" do
    ba = BitArray.new
    ba.size = 10
    ba[1] = 1
    ba[4] = 1
    ba[6] = 1
    ba[7] = 1
    ba[9] = 1
    pp ba
    ba.rank(6).should eq 2
    ba.select(4).should eq 8
  end
end
