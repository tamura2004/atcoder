require "crystal/graph"

n, m = gets.to_s.split.map(&.to_i64)
g = n.to_g
m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv
end

w = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

ans = 0_i64
w.zip(0..).sort.reverse_each do |ww, v|
  next if a[v] == 0
  ans += a[v]
  g.each(v) do |nv|
    next unless w[nv] < ww
    a[nv] += a[v]
  end
  a[v] = 0_i64
end

pp ans
