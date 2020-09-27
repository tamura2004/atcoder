require "spec"
require "../segment_tree"

describe SegmentTree do
  it "usage" do
    v = Array(Int64?).new(10, nil)
    obj = SegmentTree(Int64).new(v)
    obj[2] = 1_i64 << 21
    obj[3] = 1_i64 << 20
    obj[4] = 1_i64 << 22
    obj[2..4].should eq 1_i64 << 20
  end
end
