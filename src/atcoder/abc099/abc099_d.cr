n, m = gets.to_s.split.map(&.to_i64)
d = Array.new(m){gets.to_s.split.map(&.to_i64)}
c = Array.new(n){gets.to_s.split.map(&.to_i64.pred)}

cnt = make_array(0_i64, 3, m)
n.times do |i|
  n.times do |j|
    k = (i + j) % 3
    cnt[k][c[i][j]] += 1
  end
end

ans = Int64::MAX
(0...m).to_a.each_permutation(3) do |a|
  wk = 0_i64
  3.times do |i|
    m.times do |j|
      wk += cnt[i][j] * d[j][a[i]]
    end
  end
  chmin ans, wk
end

pp ans