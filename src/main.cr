n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)

ans = [0_i64] * 3
(n - 1).times do |i|
  d = a[i + 1] - a[i]
  ans << ans[-3] + d
end

mins = [0_i64] * 3
(n + 2).times do |i|
  chmin mins[i % 3], ans[i]
end

(n + 2).times do |i|
  ans[i] -= mins[i % 3]
end

cnt = a[0] - ans[0..2].sum
if cnt < 0
  puts "No"
else
  (n + 2).times do |i|
    if i % 3 == 0
      ans[i] += cnt
    end
  end
  puts "Yes"
  puts ans.join(" ")
end
