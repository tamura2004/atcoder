require "spec"
require "../coodinate_compress_segment_tree"

alias Pair = Tuple(Int32, Int32)

describe CoodinateCompressSegmentTree do
  it "usage, default range sum" do
    st = CCST(Int32, Int32).new([1, 100, 1000])
    st[100] += 200
    st[1000] += 2000
    st[..1000].should eq 2200
  end

  it "init with values" do
    st = CCST(Int32, Int32).new([1, 100, 1000], values: [2, 20, 200])
    st[..1000].should eq 222
    st[1...1000].should eq 22
  end

  it "can have same key" do
    st = CCST(Int32, Int32).new([100, 100, 1000], values: [20, 10, 100])
    st[100].should eq 10
    st[100...1000].should eq 10
    st[100..1000].should eq 110
  end

  it "range min query" do
    st = CCST(Int32, Int32).new([1, 10, 100], [200, 20, 2], Int32::MAX) do |x, y|
      Math.min x, y
    end

    st[..100].should eq 2
    st[...100].should eq 20
    st[100] = 10
    st[..100].should eq 10
  end

  it "int64 range sum" do
    keys = 4.times.map { |i| Int64::MAX - i }.to_a
    values = [10_i64 ** 9] * 4
    st = CCST.new(keys, values)
    st[(Int64::MAX - 3)...Int64::MAX].should eq 10_i64 ** 9 * 3
  end

  it "other monoid" do
    keys = [10_000_000, 20_000_000, 30_000_000]
    values = [{1, 2}, {2, 3}, {3, 4}]
    unit = {1, 0}
    st = CCST(Int32, Pair).new(keys, values, unit) do |(x0, x1), (y0, y1)|
      {x0 * y0, x1 * y0 + y1}
    end
    st[10_000_000..30_000_000].should eq ({6, 25})
  end
end
