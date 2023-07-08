# 操作による不変量を探す
# a3..anをあらかじめ並べ替えて昇順にしてよい
# ai..ai+m-1はｍ個以上になるがこれが含まれるには
# a1 == ai, a2 == ai+m-1
# aiを全探索

n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
a1 = a.shift
a2 = a.shift
a.sort!

ans = Int64::MAX
a.each_index do |i|
  j = i + m - 1
  next if a.size - 1 < j 
  a1_move = Math.max a1 - a[i], 0i64
  a2_move = Math.max a[j] - a2, 0i64
  chmin ans, a1_move + a2_move
end

pp ans