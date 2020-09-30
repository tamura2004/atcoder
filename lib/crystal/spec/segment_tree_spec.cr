require "spec"
require "../segment_tree"

describe SegmentTree do
  it "basic usage" do
    v = Array(Int64?).new(10, nil)
    obj = SegmentTree(Int64).new(v)
    obj[2] = 1_i64 << 21
    obj[3] = 1_i64 << 20
    obj[4] = 1_i64 << 22
    obj[2..4].should eq 1_i64 << 20
  end

  it "to_a" do
    v = [{1, 10_i64}, {2, 20_i64}]
    obj = SegmentTree(Tuple(Int32, Int64)).new(v) do |a, b|
      Tuple(Int32, Int64).new(
        Math.min(a[0], b[0]),
        Math.max(a[1], b[1])
      )
    end
    obj.to_a.should eq v
    obj[0] = {0, 5_i64}
    obj[0...2].should eq ({0, 20_i64})
  end

  it "solve abc134e" do
    cases = [
      {5, [2, 1, 4, 5, 3], 2},
      {4, [0, 0, 0, 0], 4},
    ]
    cases.each do |n, a, want|
      ABC134E.new(n, a).solve.should eq want
    end
  end
end

# https://atcoder.jp/contests/abc134/tasks/abc134_e
class ABC134E
  getter n : Int32
  getter m : Int32
  getter a : Array(Int32)
  getter st : SegmentTree(Int64)

  def initialize(@n, a)
    @a = compress(a)
    @m = @a.max.to_i
    @st = SegmentTree(Int64).new(m + 1) do |a, b|
      a < b ? b : a
    end
  end

  def solve
    a.each do |v|
      i = st[v..m] || 0
      st[v] = i + 1
    end
    st[0..m]
  end

  def compress(a)
    b = a.sort.uniq
    a.map do |a|
      b.bsearch_index do |b|
        a <= b
      end.not_nil!
    end
  end
end
