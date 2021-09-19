require "spec"
require "crystal/xor_sum"

describe XORSum do
  it "usage" do
    XORSum.new([0,1,2]).solve.should eq 6
  end
end

