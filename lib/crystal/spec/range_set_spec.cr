require "spec"
require "../range_set"

describe RangeSet do
  it "usage" do
    s = RangeSet(Int32).new
    s << (1..3)
    s.size.should eq 3
    s << (5..7)
    s.size.should eq 6
    s << (3..5)
    s.size.should eq 7
  end
end
