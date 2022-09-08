# クエリ先読み
# 深さ順にまとめる
# 差分取る
require "crystal/graph"
require "crystal/graph/h_l_decomposition"
require "crystal/graph/depth"
require "crystal/segment_tree"
require "crystal/wavelet_matrix"

def random_tree(n)
  g = Graph.new(n)
  (1...n).each do |v|
    g.add v, rand(0...v), origin: 0
  end
  g
end

def random_query(n, q)
  Array.new(q) do |i|
    {rand(0...n), rand(0...n), i}
  end
end

n = gets.to_s.to_i
plist = gets.to_s.split.map(&.to_i)
g = Graph.new([-1] + plist)

q = gets.to_s.to_i
qs = Array.new(q) do |i|
  v, d = gets.to_s.split.map(&.to_i)
  v = v.pred
  {v, d, i}
end

# N = 5
# 10.times do
#   g = random_tree(N)
#   q = N
#   qs = random_query(N,N)

# want = Want.new(g, q, qs).solve
got = Got.new(g, q, qs).solve
puts got.join("\n")
# if want != got
#   pp! want
#   pp! got
#   puts g
#   pp! qs
#   exit
# end

# end

class Got
  getter g : IGraph
  delegate n, to: g
  getter qs : Array(Tuple(Int32, Int32, Int32))
  getter q : Int32

  def initialize(@g, @q, @qs)
  end

  def solve
    et = HLDecomposition.new(g, 0)
    enter, leave = et.enter, et.leave
    depth = Depth.new(g).solve(0)
    values = Array.new(n, n)
    depth.each_with_index do |d, v|
      values[enter[v]] = d.to_i
    end
    mt = WaveletMatrix(Int32).new(values)
    ans = Array.new(q, 0)

    # pp! values
    # pp! enter[0]
    # pp! leave[0]
    # pp! mt.rank(4, 0..4)

    qs.each do |v, d, i|
      ans[i] = mt.rank(d, enter[v]..leave[v])
    end

    ans
  end
end

class Want
  getter g : IGraph
  delegate n, to: g
  getter qs : Array(Tuple(Int32, Int32, Int32))
  getter q : Int32

  def initialize(@g, @q, @qs)
  end

  def solve
    query_by_depth = qs.group_by(&.[1])

    st = n.to_st_sum
    et = HLDecomposition.new(g, 0)
    enter, leave = et.enter, et.leave
    depth = Depth.new(g).solve(0)
    depth_hash = (0...n).group_by { |i| depth[i] }

    ans = Array.new(q, 0)
    n.times do |d|
      query_by_depth[d]?.try &.each do |v, _, i|
        # qs[d].each do |v, i|
        ans[i] -= st[enter[v]..leave[v]]
      end

      depth_hash[d]?.try &.each { |v|
        st[enter[v]] += 1
      }

      query_by_depth[d]?.try &.each do |v, _, i|
        # qs[d].each do |v, i|
        ans[i] += st[enter[v]..leave[v]]
      end
    end
    ans
  end
end
