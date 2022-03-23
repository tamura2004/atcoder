require "crystal/tree"
require "crystal/mod_int"
line = gets.to_s.split.map(&.to_i64)
A = line[0]
B = line[1]

N = gets.to_s.to_i
G = Tree.new(N)
(N - 1).times do
  v, nv = gets.to_s.split.map(&.to_i64)
  G.add v, nv
end
D = Array.new(N, 1_i64)

dfs1(0, -1)
pp D

def dfs1(v, pv)
  G[v].each do |nv|
    next if nv == pv
    D[v] += dfs1(nv, v)
  end
  D[v]
end
