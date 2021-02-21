require "spec"
require "../lazy_segment_tree"

describe LazySegmentTree do
  it "range add range min" do
    x = Array.new(8, 0)
    xy = -> (x : Int32, y : Int32) { Math.min x, y }
    xa = -> (x : Int32, a : Int32) { x + a }
    ab = -> (a : Int32, b : Int32) { a + b }
    st = LazySegmentTree(Int32,Int32).new(x,xy,xa,ab)
    st.update(0,6,2)
    st.update(2,8,3)
    st.fold(0,2).should eq 2
    st.fold(2,6).should eq 5
    st.fold(6,8).should eq 3
  end
end
