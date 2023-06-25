n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
ans = [] of Int64
a.each_slice(7) do |b|
  ans << b.sum
end
puts ans.join(" ")
