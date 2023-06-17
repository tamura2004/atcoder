n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64.pred)

cnt = Array.new(n, 0)
ans = Array.new(n, -1_i64)

(n*3).times do |i|
  cnt[a[i]] += 1
  if cnt[a[i]] == 2
    ans[a[i]] = i.succ
  end
end

puts ans.zip(1..).sort.map(&.last).join(" ")

