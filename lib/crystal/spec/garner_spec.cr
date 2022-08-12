require "spec"
require "crystal/garner"

describe NTT do
  it "usage" do
    ntt = NTT(998_244_353, 3).new
    a = [3, 2, 1]
    b = [6, 5, 4]
    c = ntt.convolution(a, b)
    c.should eq [18, 27, 28, 13, 4]
  end
end
