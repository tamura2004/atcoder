require "spec"
require "crystal/lazy_segment_tree"

describe LazySegmentTree do
  it "range update range min" do
    st = LazySegmentTree(Int32, Int32).range_update_range_min(4)

    st[..2] = 3
    st[2..] = 2 # [3, 3, 2, 2]

    st[..1].should eq 3
    st[0..].should eq 2
    st[2..].should eq 2
  end

  it "range add range min" do
    values = Array.new(4, 0)
    st = LazySegmentTree(Int32,Int32).range_add_range_min(values)
    st[..2] = 3
    st[2..] = 2 # [3, 3, 5, 2]

    st[1].should eq 3
    st[2].should eq 5
    st[3].should eq 2
    st[..2].should eq 3
    st[2..].should eq 2
  end

  it "range update range sum" do
    values = Array.new(4){ Tuple(Int64,Int64).new(0_i64, 1_i64) }
    st = LazySegmentTree(Tuple(Int64,Int64), Int64?).range_update_range_sum(values)
    st[0..] = 2_i64 # [2, 2, 2, 2]
    st[1..] = 3_i64 # [2, 3, 3, 3]
    st[0..].should eq Tuple(Int64,Int64).new(11_i64, 6_i64)
  end
end
