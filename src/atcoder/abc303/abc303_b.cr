n, m = gets.to_s.split.map(&.to_i64)
a = Array.new(m) { gets.to_s.split.map(&.to_i64.pred) }

cnt = Array.new(n){Array.new(n, 1_i64)}
n.times{|i|cnt[i][i] = 0_i64}

m.times do |i|
  n.pred.times do |j|
    v = a[i][j] 
    nv = a[i][j+1]
    cnt[v][nv] = 0_i64 
    cnt[nv][v] = 0_i64 
  end
end

ans = cnt.flatten.sum // 2
pp ans
