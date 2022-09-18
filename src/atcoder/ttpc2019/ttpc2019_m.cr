# 1 - 5 - 2 - 1
#     |
#     4

require "crystal/graph"
require "crystal/graph/euler_tour"
require "crystal/wavelet_matrix"

n = gets.to_s.to_i
g = Graph.new(n)
(n - 1).times do
  g.read
end

elt = EulerTour.new(g, 0)

values = elt.events.map do |v, ev|
  case ev
  when .enter?
    v.to_i64
  else
    Int64::MAX
  end
end
wm = WaveletMatrix(Int64).new(values)

# rootの部分木で、v未満の頂点の数
less = -> (root : Int32, v : Int32) do
  lo = elt.enter[root]
  hi = elt.leave[root]
  wm.range_freq(lo..hi, 0_i64...v.to_i64)
end

ans = Array.new(n, 0_i64)
pa = Array.new(n, -1)

# 転倒数
dfs = uninitialized (Int32, Int32) -> Nil
dfs = -> (v : Int32, pv : Int32) do
  pa[v] = pv
  ans[0] += less.call(v, v)
 
  g.each(v) do |nv|
    next if nv == pv
    dfs.call(nv, v)
  end
end
dfs.call(0, -1)

dfs2 = uninitialized (Int32, Int32) -> Nil
dfs2 = -> (v : Int32, pv : Int32) do
  if pv != -1
    ans[v] = ans[pv] - less.call(v, pv) + less.call(0,v) - less.call(v, v)
  end

  g.each(v) do |nv|
    next if nv == pv
    dfs2.call(nv, v)
  end
end
dfs2.call(0, -1)

puts ans.join("\n")