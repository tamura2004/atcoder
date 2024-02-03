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

  # it "range update range sum" do
  #   st = LazySegmentTree(Tuple(Int64,Int64)?, Int64?).range_update_range_sum(10)
  # end

  # it "range add range max" do
  #   st = LazySegmentTree(Int32,Int32).new(
  #     values: [-1,-3,2,-5],
  #     fxx: -> (x : Int32, y : Int32) {
  #       Math.max(x, y)
  #     },
  #     fxa: -> (x : Int32, a : Int32) {
  #       x + a
  #     },
  #     faa: -> (a : Int32, b : Int32) {
  #       a + b
  #     },
  #     x_unit: Int32::MIN,
  #     a_unit: 0
  #   )

  #   st[0..].should eq 2
  #   st[1..] = -3
  #   st[0..].should eq -1
  # end
end
