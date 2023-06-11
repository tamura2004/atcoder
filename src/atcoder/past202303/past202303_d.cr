h,a,b,c,d = gets.to_s.split.map(&.to_i64)

# アイテム２を使用できる回数で全探索
cnt = 0_i64
cost = 0_i64
ans = divceil(h, a) * b

while h > 0
  cnt += 1
  cost += d
  h -= c
  h -= h // 2 if h > 0
  chmax h, 0_i64
  chmin ans, cost + divceil(h, a) * b
end

pp ans
