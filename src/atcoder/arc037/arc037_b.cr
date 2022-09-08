# require "crystal/union_find"

# n, m = gets.to_s.split.map(&.to_i)
# uf = n.to_uf

# m.times do
#   v, nv = gets.to_s.split.map(&.to_i.pred)
#   uf.unite v, nv
# end

# ans = Set(Int32).new
# n.times do |v|
#   if uf.vertex_size(v) - 1 == uf.edge_size(v)
#     ans << uf.find(v)
#   end
# end

# puts ans.size

# dfs版
require "crystal/graph"

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
m.times { g.read }
seen = Hash(Int32,Bool).new(false)

dfs = uninitialized (Int32, Int32) -> Bool
dfs = -> (v : Int32, pv : Int32) do
  # pp! [v,pv]
  return false if seen[v]
  seen[v] = true
  ans = true

  g.each(v) do |nv|
    next if nv == pv
    if seen[nv]
      ans = false
    else
      ans &&= dfs.call(nv, v)
    end
  end

  ans
end

ans = 0
# pp! dfs.call(0,-1)
# pp! dfs.call(4,-1)
n.times do |v|
  if dfs.call(v, -1)
    ans += 1
  end
end

pp ans