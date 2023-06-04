require "crystal/union_find"
require "crystal/indexable"

class Graph
  getter n : Int32
  getter g : Array(Set(Int32))
  delegate "[]", to: g

  def initialize(@n)
    @g = Array.new(n){Set(Int32).new}
  end

  def add(v, nv)
    g[v] << nv
    g[nv] << v
  end
end

n, m = gets.to_s.split.map(&.to_i64)
uf = n.to_uf
m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  uf.unite(v, nv)
end

pa = uf.group_parents
ix = Array.new(n, -1)
pa.each_with_index do |v, i|
  ix[v] = i
end

g = Graph.new(uf.size)
k = gets.to_s.to_i64
k.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  g.add ix[uf.find(v)], ix[uf.find(nv)]
end

q = gets.to_s.to_i64
q.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  puts ix[uf.find(nv)].in?(g[ix[uf.find(v)]]) ? "No" : "Yes"
end
    