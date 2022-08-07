require "crystal/prime"
require "crystal/flow_graph/dinic"

n = gets.to_s.to_i64
ab = Array.new(n) do |v|
  a, b = gets.to_s.split.map(&.to_i64)
  {a, b, v}
end

even = ab.select(&.first.even?)
odd = ab.select(&.first.odd?)

root = n
goal = n + 1
g = Graph.new(n+2)

even.each do |a, b, v|
  g.add root, v, b
end

odd.each do |a, b, v|
  g.add v, goal, b
end

even.each do |al, bl, v|
  odd.each do |ar, br, nv|
    if (al + ar).is_prime?
      g.add v, nv, Math.min(bl, br)
    end
  end
end

ans = Dinic.new(g).solve(root, goal)

odd.each do |a,b,v|
  if a == 1
    ans += g[v].first.cap >> 1
  end
end

pp ans
