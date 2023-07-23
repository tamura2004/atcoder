# dfsをして後退辺を見つけたら、その先をrootとしてrootまで巻き戻す

require "crystal/graph"
require "crystal/graph/scc"

n = gets.to_s.to_i64
g = n.to_g
nex = gets.to_s.split.map(&.to_i.pred)

nex.each_with_index do |nv, v|
  g.add v, nv, both: false, origin: 0
end

scc = SCC.new(g).solve
scc.each do |cycle|
  next if cycle.size == 1
  puts cycle.size
  cycle.reverse! if nex[cycle[0]] != cycle[1]
  puts cycle.map(&.succ).join(" ")
  exit
end