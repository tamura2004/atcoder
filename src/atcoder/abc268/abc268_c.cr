n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
ans = Array.new(n, 0)

a.each_with_index do |v, i|
  j = (v - i) % n
  ans[j] += 1
  ans[(j - 1) % n] += 1
  ans[(j + 1) % n] += 1
end

pp ans.max
