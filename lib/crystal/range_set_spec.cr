require "spec"
require "crystal/range_set"

describe RangeSet do
  it "usage" do
    s = RangeSet.new
    s << (1...2)
    s.size.should eq 1
    s << (3...4)
    s.size.should eq 2
    s << (2...3)
    s.size.should eq 1
    pp s
  end
end
