require "spec"
require "../lazy_segment_tree"

alias F = Int32?, Int32? -> Int32?
alias G = Int32, Int32 -> Int32

describe LazySegmentTree do
  it "range add range min" do
    x = Array.new(8, 0)
    xy = G.new { |x, y| Math.min x, y }
    xa = G.new { |x, a| x + a }
    ab = G.new { |a, b| a + b }
    st = LazySegmentTree(Int32, Int32, F, F, F).new(x, xy, xa, ab)
    st.update(0, 6, 2)
    st.update(2, 8, 3)
    st.fold(0, 2).should eq 2
    st.fold(2, 6).should eq 5
    st.fold(6, 8).should eq 3
  end
end
