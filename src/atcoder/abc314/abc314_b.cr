n = gets.to_s.to_i
dp = Array.new(n) { Array.new(37, Int32::MAX) }
ci = [] of Int32
n.times do |i|
  c = gets.to_s.to_i
  ci << c
  ai = gets.to_s.split.map(&.to_i.pred)
  ai.each do |j|
    dp[i][j] = c
  end
end
x = gets.to_s.to_i.pred

cnt = (0...n).min_of do |i|
  dp[i][x]
end

quit 0 if cnt == Int32::MAX

ans = [] of Int32
n.times do |i|
  if dp[i][x] == cnt
    ans << i
  end
end

puts ans.size
puts ans.map(&.succ).join(" ")
