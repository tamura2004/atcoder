require "crystal/flow_graph/dinic"
include FlowGraph

INF = Int64::MAX

h, w = gets.to_s.split.map(&.to_i64)
a = Array.new(h) { gets.to_s }

g = Graph(Int32).new(h + w + 2)
# 縦 0...h
# 横 h...h+w
# 始点 h+w
# 終点 h+w+1

root = h + w
goal = root + 1

sy = sx = gy = gx = -1

h.times do |y|
  w.times do |x|
    case a[y][x]
    when 'S'
      sy, sx = y, x
      g.add root, y, INF
      g.add root, h + x, INF
    when 'T'
      gy, gx = y, x
      g.add y, goal, INF
      g.add h + x, goal, INF
    when 'o'
      g.add y, h + x, 1
      g.add h + x, y, 1
    end
  end
end

quit -1 if sy == gy || sx == gx

ans = Dinic(Int32).new(g).solve(root, goal)
pp ans
