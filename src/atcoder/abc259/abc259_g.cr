require "crystal/flow_graph/dinic"
include FlowGraph

INF = 1e15.to_i64

h, w = gets.to_s.split.map(&.to_i64)
n = h + w + 2

root = 0
goal = n - 1

a = Array.new(h) { gets.to_s.split.map(&.to_i64) }

# 縦横合計
tate = Array.new(h) { |i| a[i].sum }
yoko = Array.new(w) { |i| (0...h).sum { |j| a[j][i] } }

# 正のコストの合計
sum = tate.select(&.> 0).sum
sum += yoko.select(&.> 0).sum

g = Graph(Int64).new(n)

# 始点から横列合計へ（取る）
h.times do |i|
  if tate[i] < 0
    g.add root, i + 1, -tate[i]
  end
end

# 始点から縦列合計へ（取らない）
w.times do |i|
  if yoko[i] > 0
    g.add root, i + h + 1, yoko[i]
  end
end

# 横列合計から終点へ（取らない）
h.times do |i|
  if tate[i] > 0
    g.add i + 1, goal, tate[i]
  end
end

# 横列合計から終点へ（取る）
w.times do |i|
  if yoko[i] < 0
    g.add i + h + 1, goal, -yoko[i]
  end
end

# 縦列合計から横列合計へ（両方取る）
h.times do |y|
  w.times do |x|
    v = x + h + 1
    nv = y + 1

    if a[y][x] < 0
      g.add v, nv, INF
    else
      g.add v, nv, a[y][x]
    end
  end
end

# g.debug
cnt = Dinic(Int64).new(g).solve
ans = sum - cnt
# pp! sum
# pp! cnt
# pp! tate
# pp! yoko
# g.debug
pp ans
