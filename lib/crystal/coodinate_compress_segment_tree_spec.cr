require "spec"
require "crystal/coodinate_compress_segment_tree"

describe CoodinateCompressSegmentTree do
  it "usage" do
    a = 100_000_000_i64
    b = 200_000_000_i64
    c = 300_000_000_i64
    d = 400_000_000_i64
    keys = [a, b, c, d]
    st = CCST(Int64, Int32).new(keys, ->(x : Int32, y : Int32) { x + y })
    st[a] = 1
    st[b] = 2
    st[c] = 3
    st[d] = 4
    st[b..c].should eq 5
    st[..c].should eq 6
    st[...c].should eq 3
    st[b] = 7
    st[b..c].should eq 10
  end

  it "usage range max" do
    st = CCST(Int64, Int64).new([1e9.to_i64, 2e9.to_i64], ->(x : Int64, y : Int64) { Math.max x, y })
    st[1e9.to_i64] = 10
    st[1e9.to_i64..].should eq 10
  end

  # it "initialize with hash" do
  #   hash = {
  #     100_000_000_i64 => 1,
  #     200_000_000_i64 => 2,
  #     300_000_000_i64 => 3
  #   }
  #   st = CCST.new(hash, unit: 0) { |x, y| x + y }
  #   st[200_000_000_i64..300_000_000_i64].should eq 5
  # end

  # it "usage, default range sum" do
  #   # valuesを省略した場合はゼロで初期化
  #   st = CCST(Int32, Int32).new(keys: [1, 100, 1000])
  #   st[100] += 200
  #   st[1000] += 2000
  #   st[..1000].should eq 2200
  # end

  # it "init with values" do
  #   st = CCST(Int32, Int32).new(keys: [1, 100, 1000], values: [2, 20, 200], unit: 0) do |x, y|
  #     x + y
  #   end
  #   st[..1000].should eq 222
  #   st[1...1000].should eq 22
  # end

  # it "can have same key" do
  #   st = CCST(Int32, Int32).new([100, 100, 1000], values: [20, 10, 100])
  #   st[100].should eq 10
  #   st[100...1000].should eq 10
  #   st[100..1000].should eq 110
  # end

  # it "range min query" do
  #   st = CCST(Int32, Int32).new([1, 10, 100], [200, 20, 2], Int32::MAX) do |x, y|
  #     Math.min x, y
  #   end

  #   st[..100].should eq 2
  #   st[...100].should eq 20
  #   st[100] = 10
  #   st[..100].should eq 10
  # end

  # it "int64 range sum" do
  #   keys = 4.times.map { |i| Int64::MAX - i }.to_a
  #   values = [10_i64 ** 9] * 4
  #   st = CCST.new(keys, values)
  #   st[(Int64::MAX - 3)...Int64::MAX].should eq 10_i64 ** 9 * 3
  # end

  # it "other monoid" do
  #   keys = [10_000_000, 20_000_000, 30_000_000]
  #   values = [{1, 2}, {2, 3}, {3, 4}]
  #   unit = {1, 0}
  #   st = CCST(Int32, Tuple(Int32, Int32)).new(keys, values, unit) do |(x0, x1), (y0, y1)|
  #     {x0 * y0, x1 * y0 + y1}
  #   end
  #   st[10_000_000..30_000_000].should eq ({6, 25})
  # end
end
