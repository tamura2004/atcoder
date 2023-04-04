a,b,x = gets.to_s.split.map(&.to_i64)
cnt = 1e9.to_i64
ans = 0_i64

def ketawa(n)
  n.to_s.chars.sum(&.to_i64)
end

quit cnt if cnt * a + ketawa(cnt) * b <= x
cnt //= 10

while cnt > 0
  (0..9).reverse_each do |i|
    cost = cnt * i * a + b * i
    if cost <= x
      ans += cnt * i
      x -= cost
    end
  end
  cnt //= 10
end

pp ans
