# dilworthの定理
require "crystal/flow_graph/max_flow"

def each_substring(s)
  n = s.size
  (0...n).each do |i|
    (i...n).each do |j|
      yield s[i..j]
    end
  end
end

def is_kaibun?(s)
  n = s.size
  (0...(n//2)).all? do |i|
    s[i] == s[n-1-i]
  end
end

s = gets.to_s
nodes = [] of String
each_substring(s) do |ss|
  nodes << ss if is_kaibun?(ss)
end

nodes.uniq!
n = nodes.size
g = Graph.new(n*2+2)
root = n * 2
goal = root + 1

(0...n).each do |i|
  g.add root, i, 1_i64, origin: 0
  g.add i+n, goal, 1_i64, origin: 0
end

(0...n).each do |i|
  (0...n).each do |j|
    next if i == j
    if nodes[i] == nodes[j]
      g.add(i, j+n, 1_i64, origin: 0)
    elsif nodes[i].in?(nodes[j])
      g.add(i, j+n, 1_i64, origin: 0)
    elsif nodes[j].in?(nodes[i])
      g.add(j, i+n, 1_i64, origin: 0)
    end
  end
end
ans = n - MaxFlow.new(g).solve(root, goal)
pp ans