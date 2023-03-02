require "spec"
require "crystal/modint9"
require "crystal/ntt"

describe NTT do
  it "usage" do
    NTT.conv([1,1,1],[1,1,1]).should eq [1,2,3,2,1]
  end
end
