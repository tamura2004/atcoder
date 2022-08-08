require "crystal/flow_graph/dinic"
require "crystal/prime"

n = gets.to_s.to_i64
ab = Array.new(n) do |v|
  a, b = gets.to_s.split.map(&.to_i64)
  {a, b, v}
end

g = Graph.new(n*2 + 2)
root = n*2
goal = n*2 + 1

ab.each do |a, b, v|
  g.add root, v, b
  g.add v + n, goal, b
end

ab.each do |la, lb, lv|
  ab.each do |ra, rb, rv|
    if (la + ra).is_prime?
      g.add lv, rv + n, Math.min(lb, rb)
    end
  end
end

ans = Dinic.new(g).solve(root, goal)
pp ans // 2
