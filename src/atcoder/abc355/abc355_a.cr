a = gets.to_s.split.map(&.to_i64)

if a.uniq.size == 2
  ans = [1, 2, 3] - a
  puts ans[0]
else
  puts -1
end
