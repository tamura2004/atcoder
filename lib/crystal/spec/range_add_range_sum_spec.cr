require "spec"
require "../range_add_range_sum"

describe RangeAddRangeSum do
  it "usage" do
    st = RangeAddRangeSum.new(10)
    st[0..5] = 10
    st[0..3].should eq 50
  end
end
