n, m = gets.to_s.split.map(&.to_i)
s = gets.to_s
c = gets.to_s.split.map(&.to_i.pred)

cnt = Array.new(m) { [] of Int32 }
n.times do |i|
  cnt[c[i]] << i
end

ans = Array.new(m) do |i|
  cnt[i].rotate.zip cnt[i]
end.flatten.sort.map(&.last).map { |i| s[i] }.join

puts ans
