n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

ans = [] of Int64
a.each_cons_pair do |i, j|
    ans << i * j
end

puts ans.join(" ")
