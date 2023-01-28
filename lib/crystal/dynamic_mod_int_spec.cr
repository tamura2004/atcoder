require "spec"
require "crystal/dynamic_mod_int"

describe ModInt do
  it "usage" do
    ModInt.mod = 7
    (1.to_m + 2).should eq 3.to_m 
    (1.to_m - 2).should eq 6.to_m 
    (3.to_m * 2).should eq 6.to_m 
    3.fact.should eq 6.to_m
    6.finv.should eq 6.to_m
    6.inv.should eq 6.to_m
    6.to_m.pow(3).should eq 6.to_m
    4.c(2).should eq 6.to_m
  end

  it "large mod" do
    ModInt.mod = 998_244_353_i64
    ModInt.maxi = 100000
    10000.c(5000).should eq 156178480.to_m
  end
end
