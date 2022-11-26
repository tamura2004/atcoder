# 2と3とそれ以外
# それ以外がすべて一致しないなら、-1
# 2.min, 3.minとの差分を合計

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)

c2 = Array.new(n, 0_i64)
c3 = Array.new(n, 0_i64)

n.times do |i|
  while a[i].divisible_by?(2)
    c2[i] += 1
    a[i] //= 2
  end

  while a[i].divisible_by?(3)
    c3[i] += 1
    a[i] //= 3
  end
end

quit -1 if a.uniq.size != 1

ans = c2.sum - (c2.min * n)
ans += c3.sum - (c3.min * n)

pp ans
  
