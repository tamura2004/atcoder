require "crystal/modint9"
require "crystal/union_find"
require "crystal/graph"

n = gets.to_s.to_i
uf = n.to_uf
g = (n*2).to_g
nodes = Array.new(n) { [] of Int32 }
size = Array.new(n*2, 0_i64)
last_ix = n
n.times do |i|
  nodes[i] << i
  size[i] = 1_i64
end

(n - 1).times do |i|
  v, nv = gets.to_s.split.map(&.to_i.pred)

  v = uf.find(v)
  nv = uf.find(nv)
  vcnt = uf.v_size[v]
  nvcnt = uf.v_size[nv]

  uf.unite v, nv
  pv = uf.find(v)
  vix = nodes[v][-1]
  nvix = nodes[nv][-1]
  nodes[pv] << last_ix
  g.add vix, last_ix, origin: 0, both: true
  g.add nvix, last_ix, origin: 0, both: true
  size[last_ix] = size[vix] + size[nvix]
  last_ix += 1
end

ans = Array.new(n*2, 0.to_m)

root = n*2 - 2
dfs = uninitialized (Int32, Int32) -> Nil
dfs = ->(v : Int32, pv : Int32) do
  g.each(v) do |nv|
    next if nv == pv
    ans[nv] += size[nv].to_m // size[v] + ans[v]
    dfs.call(nv, v)
  end
end
dfs.call(root, -1)

puts ans[0...n].join(" ")
