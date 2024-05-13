n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i.pred)
ix = a.zip(0..).sort.map(&.last)

ans = [] of Tuple(Int32,Int32)
n.times do |i|
  next if a[i] == i
  j = ix[i]

  ans << {i.succ, j.succ}
  ix[a[i]] = j
  ix[a[j]] = i
  a.swap(i, j)
end

puts ans.size
puts ans.map(&.join(" ")).join("\n")


