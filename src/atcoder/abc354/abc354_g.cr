require "crystal/flow_graph/max_flow"

n = gets.to_s.to_i64
s = Array.new(n) { gets.to_s }
a = gets.to_s.split.map(&.to_i64)

g = Graph.new(n*2+2)

root = 0
goal = n*2+1

n.times do |v|
  g.add root, v + 1, a[v]
  g.add v + n + 1, goal, a[v]
end

n.times do |v|
  n.times do |nv|
    next if v == nv
    if s[v] == s[nv]
      if v < nv
        g.add v+1, nv + n+1, Int64::MAX
      end
    elsif s[nv].includes?(s[v])
      g.add v+1, nv + n+1, Int64::MAX
    end
  end
end

maxi = MaxFlow.new(g).solve(root, goal)
ans = a.sum - maxi
pp ans
