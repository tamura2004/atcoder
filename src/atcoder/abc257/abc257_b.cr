n,k,q = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i.pred)
l = gets.to_s.split.map(&.to_i.pred)

l.each do |i|
  next if a[i] == n - 1
  next if i < k - 1 && a[i] + 1 == a[i+1]
  a[i] += 1
end

puts a.map(&.succ).join(" ")