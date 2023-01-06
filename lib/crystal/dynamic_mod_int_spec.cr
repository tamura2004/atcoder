require "spec"
require "crystal//dynamic_mod_int"

describe DynamicModInt do
  it "usage" do
    mint = DynamicModInt.new(7_i64)
    mint.fact[3].should eq 6
    mint.finv[6].should eq 6
    mint.pow(6,3).should eq 6
  end
end
