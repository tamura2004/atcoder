n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

tot = k * (k + 1) // 2
b = a.select(&.<= k).uniq

ans = tot - b.sum
pp ans
