require "spec"
require "crystal/segment_tree"

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

  it "range sum bsearch" do
    st = SegmentTree(Int32).new([0, 1, 0, 1, 1, 0, 1, 1])
    st.bsearch(2).should eq 3
    st.bsearch(3).should eq 4
    st.bsearch(4).should eq 6
    st.bsearch(5).should eq 7
    st.bsearch(6).should eq 7 # overflow
  end

  it "range sum bsearch" do
    st = SegmentTree(Int32).new([1, 2, 1, 2, 1, 0, 1, 1, 1])
    st.bsearch(3).should eq 1
    st.bsearch(4).should eq 2
    st.bsearch(6).should eq 3
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

  it "一点更新、区間最小、要素数で初期化" do
    st = SegmentTree(Int32).min(10)
    st[1] = 10
    st[2] = 5
    st[3] = 20
    st[1..].should eq 5
    st[2..].should eq 5
    st[3..].should eq 20
  end

  it "range sum query" do
    st = SegmentTree(Int32).sum(10)
    st[1] = 10
    st[2] = 5
    st[3] = 20
    st[1..].should eq 35
    st[2..].should eq 25
    st[3..].should eq 20
  end

  it "range max query" do
    st = SegmentTree(Int32).max(10)
    st[1] = 10
    st[2] = 5
    st[3] = 20
    st[1..].should eq 20
    st[2..].should eq 20
    st[3..].should eq 20
  end

  it "initialize sum from int" do
    st = 10.to_st_sum
    st[1] = 10
    st[2] = 20
    st[0..].should eq 30
  end

  it "initialize min from int" do
    st = 10.to_st_min
    st[1] = 10
    st[2] = 20
    st[0..].should eq 10
  end

  it "initialize max from int" do
    st = 10.to_st_max
    st[1] = 10
    st[2] = 20
    st[0..].should eq 20
  end

  it "initialize sum from indexable" do
    st = [10,20,30].to_st_sum
    st[0..].should eq 60
  end

  it "initialize min from indexable" do
    st = [10,20,30].to_st_min
    st[0..].should eq 10
  end

  it "initialize max from indexable" do
    st = [10,20,30].to_st_max
    st[0..].should eq 30
  end

end
