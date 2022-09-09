# セグ木でアンドゥしながらLIS

require "crystal/segment_tree"
require "crystal/graph"
require "crystal/indexable"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64).compress(origin: 1)

g = Graph.new(n)
(n-1).times do
  g.read
end

ans = Array.new(n, -1_i64)
st = (n+1).to_st_max

dfs = uninitialized (Int32, Int32) -> Nil
dfs = -> (v : Int32, pv : Int32) do
  i = a[v]
  undo = st[i]
  st[i] = st[...i] + 1
  ans[v] = st[0..]

  g.each(v) do |nv|
    next if nv == pv
    dfs.call(nv, v)
  end

  st[i] = undo
end
dfs.call(0, -1)

puts ans.join("\n")