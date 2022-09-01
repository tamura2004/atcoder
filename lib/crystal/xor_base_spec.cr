require "spec"
require "crystal//xor_base"

describe XorBase do
  it "usage" do
    a = [0b111, 0b011, 0b001]
    xb = XorBase.new(a)
    xb.base.should eq [0b111, 0b011, 0b001]
    xb.sweep!
    xb.base.should eq [0b100, 0b010, 0b001]
  end

  it "add" do
    xb = XorBase.new
    xb << 0b111
    xb << 0b011
    xb << 0b001
    xb << 0b101
    xb.base.should eq [0b111, 0b011, 0b001]
  end
end
