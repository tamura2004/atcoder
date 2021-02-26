require "spec"
require "../lazy_segment_tree"

alias Pair = Tuple(Int64, Int64)

describe LazySegmentTree do
  it "range add range min" do
    st = LazySegmentTree(Int32, Int32).new(
      ->(x : Int32, y : Int32) { Math.min x, y },
      ->(x : Int32, a : Int32) { x + a },
      ->(a : Int32, b : Int32) { a + b },
      n: 4,
      init: 0
    )

    st.update(0, 2, 2) # [2, 2, 0, 0]
    st.update(1, 3, 3) # [2, 5, 3, 0]

    st[..2].should eq 2
    st[0..].should eq 0
    st[1..2].should eq 3
  end

  it "range add range sum" do
    st = LazySegmentTree(Pair, Int64).new(
      Proc(Pair, Pair, Pair).new { |(x, n), (y, m)| Pair.new x + y, n + m },
      Proc(Pair, Int64, Pair).new { |(x, n), a| Pair.new x + n * a, n },
      Proc(Int64, Int64, Int64).new { |a, b| a + b },
      n: 4,
      init: Pair.new(0_i64, 1_i64)
    ) # [0, 0, 0, 0]
    st[..2] = 2_i64 # [2, 2, 2, 0]
    st[2..] = 3_i64 # [2, 2, 5, 3]
    st[1..2] = 4_i64 # [2, 6, 9, 3]
    st[0..].should eq Pair.new(20_i64, 4_i64)
  end
end
