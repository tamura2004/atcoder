require "spec"
require "crystal/range_chmin_range_sum"

describe "RangeChminRangeSum" do
  it "usage" do
    values = [3, 1, 4, 1, 5]
    st = values.to_range_chmin_range_sum
    st[0..].should eq 14
    st[..0] = 0
    st[..0].should eq 0
    st[1..3] = 2 # => [0, 1, 2, 1, 5]
    st[0..].should eq 9
    st[3..] = 0 # => [0, 1, 2, 0, 0]
    st[1..].should eq 3
    st[1..3] = -3 # => [0, -3, -3, -3, 0]
    st[0..].should eq -9
  end
end
