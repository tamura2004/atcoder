require "spec"
require "crystal/range_sum"
require "crystal/mod_int"

describe RangeSum do
  it "usage" do
    st = RangeSum(Int64).new(10)
    st[1] = 1000000000_i64
    st[2] = 1000000000_i64
    st[3] = 1000000000_i64
    st[0..].should eq 3000000000_i64
  end
  it "modint" do
    st = RangeSum(ModInt).new(10)
    st[1] = 1000000000.to_m
    st[2] = 1000000000.to_m
    st[3] = 1000000000.to_m
    st[0..].should eq 1e9.to_i64 - 14
  end

  it "usage 2" do
    st = RangeSum(Int64).new(10)
    st[0] = 3
    st[1] = 1
    st[2] = 4
    st[3] = 1
    st[4] = 5
    st[5] = 9
    st[6] = 2
    st[1..4].should eq 11
  end
end
