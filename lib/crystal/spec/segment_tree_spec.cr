require "spec"
require "../segment_tree"

alias Pair = Tuple(Int32, Int32)

describe SegmentTree do
  it "init by values size" do
    st = SegmentTree(Int32).new(10)
    st[0...].should eq 0
    st[0] = 100
    st[10] = 100
    st[...10].should eq 100
  end

  it "range sum" do
    st = SegmentTree(Int32).new([1, 2, 3])
    st[0..2].should eq 6
    st[0...2].should eq 3
    st[1] += 10 # => [1,12,3]
    st[0..2].should eq 16
  end

  it "initialized by block" do
    st = SegmentTree(Int32).new([5,2,8], 0) { |x,y| x ^ y }
    st[0..2].should eq 15
  end

  it "monoid" do
    unit = {1, 0}
    fx = Proc(Pair, Pair, Pair).new do |(x0, x1), (y0, y1)|
      {x0 * y0, x1 * y0 + y1}
    end
    st = SegmentTree(Pair).new([{1, 2}, {2, 3}, {3, 4}], unit, fx)
    st[0..2].should eq ({6, 25})
  end
end
