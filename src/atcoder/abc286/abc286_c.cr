n,a,b = gets.to_s.split.map(&.to_i64)
s = gets.to_s

ans = Int64::MAX
n.times do |i|
  cnt = 0_i64
  (n//2).times do |j|
    ii = (i + j) % n
    jj = (n - 1 + i - j) % n
    cnt += b if s[ii] != s[jj]
  end
  chmin ans, i * a + cnt
end

pp ans