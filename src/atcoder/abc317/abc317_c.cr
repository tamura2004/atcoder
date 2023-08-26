n, m = gets.to_s.split.map(&.to_i64)
d = Array.new(n) { Array.new(n, nil.as(Int64?)) }

m.times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  v -= 1
  nv -= 1
  d[v][nv] = cost
  d[nv][v] = cost
end

ans = 0_i64
(0...n).to_a.each_permutation do |a|
  cnt = 0_i64
  (n - 1).times do |i|
    if dist = d[a[i]][a[i + 1]]
      cnt += dist
      chmax ans, cnt
    else
      break
    end
  end
end

pp ans
