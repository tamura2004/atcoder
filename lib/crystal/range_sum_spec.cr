require "spec"
require "crystal/range_sum"

describe RangeSum do
  it "usage" do
    a = [3, 1, 4, 1, 5, 9, 2]
    rs = RangeSum.new(a)

    rs.sum_lower(3).should eq 7
  end
end
