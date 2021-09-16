# 強連結成分分解
n,m = gets.to_s.split.map { |v| v.to_i }
g = Array.new(n){ [] of Int32 }
rg = Array.new(n){ [] of Int32 }
m.times do
  i,j = gets.to_s.split.map { |v| v.to_i - 1}
  # i,j = gets.to_s.split.map { |v| v.to_i }
  g[i] << j
  rg[j] << i
end

# それ以上進めなくなった順番
t = Array.new(n, -1)
cnt = 0

seen = Array.new(n, false)
n.times do |i|
  next if seen[i]
  seen[i] = true
  q = Deque.new([~i,i])
  while q.size > 0
    # pp! q
    v = q.pop
    if v < 0
      t[~v] = cnt
      cnt += 1
    end
    g[v].each do |nv|
      next if seen[nv]
      seen[nv] = true
      q << ~nv
      q << nv
    end
  end
end

ans = [] of Array(Int32)
seen = Array.new(n, false)

# tの大きい順
t.zip(0..).sort.reverse.each do |_, i|
  next if seen[i]
  seen[i] = true
  cnt = [i]
  q = Deque.new([i])
  while q.size > 0
    v = q.pop
    rg[v].each do |nv|
      next if seen[nv]
      seen[nv] = true
      q << nv
      cnt << nv
    end
  end
  ans << cnt
end

pp ans