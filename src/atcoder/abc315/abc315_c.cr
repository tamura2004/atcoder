require "crystal/st"

n = gets.to_s.to_i64
st = n.to_st_max

n.times do |i|
  st[i] = 0_i64
end

ans = 0_i64
n.times do |i|
  f, s = gets.to_s.split.map(&.to_i64)
  f -= 1

  # 取る
  same = st[f]
  st[f] = 0_i64

  # 違う味
  chmax ans, st[0..] + s

  # 同じ味
  if same > s
    chmax ans, same + s // 2
  else
    chmax ans, same // 2 + s
  end

  # 戻す
  st[f] = Math.max(s, same)
end

pp ans
