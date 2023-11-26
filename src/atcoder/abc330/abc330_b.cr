n, l, r = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

ans = a.map do |v|
  v.clamp(l..r)
end

puts ans.join(" ")
