require "crystal/indexable"

n,m,xn = gets.to_s.split.map(&.to_i)
g = Array.new(n){ [] of Tuple(Int32,Int32) }
m.times do
  a,b,c = gets.to_s.split.map(&.to_i)
  a -= 1
  b -= 1
  g[a] << {b,c}
  g[b] << {a,c}
end
xs = gets.to_s.split.map(&.to_i64)

seen = Array.new(n, -1)
cnt = Array.new(n, 0)
seen[0] = 0
q = Deque.new([0])

xs.each_with_index do |x, i|
  tmp = Deque(Int32).new
  while q.size > 0
    v = q.shift
    g[v].each do |nv,cost|
      next if x < cost
      next if seen[nv] != -1
      cnt[v] += 1
      seen[nv] = i
      tmp << nv
    end
    tmp << v if cnt[v] < g[v].size
  end
  q = tmp
end

ans = Array.new(xn, 0)
seen.each_with_index do |v|
  next if v == -1
  ans[v] += 1
end
puts ans.cs[1..].join("\n")



