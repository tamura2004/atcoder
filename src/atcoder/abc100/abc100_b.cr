# 全探索
d, n = gets.to_s.split.map(&.to_i64)

cnt = 0_i64
(1..10000000).each do |i|
  a = i
  j = 0
  while a.divisible_by?(100)
    a //= 100
    j += 1
  end

  if j == d
    cnt += 1
  end

  quit i if cnt == n
end
