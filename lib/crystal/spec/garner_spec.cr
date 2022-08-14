require "spec"
require "crystal/garner"

M1 =  167772161_i128
M2 =  469762049_i128
M3 = 1224736769_i128

describe NTT do
  it "usage" do
    ntt = NTT(998_244_353, 3).new
    a = [3, 2, 1]
    b = [6, 5, 4]
    c = ntt.convolution(a, b)
    c.should eq [18, 27, 28, 13, 4]
  end

  it "garner" do
    ntt = NTT(998_244_353, 3).new
    garner([13, 17, 19], [4, 5, 7]).should eq 1603
  end

  it "garner" do
    ntt = NTT(998_244_353, 3).new
    garner([M1,M2,M3], [4, 5, 7]).should eq 1603
  end
end
