n = gets.to_s.to_i64
b = gets.to_s.split.map(&.to_i64)

ans = b.first + b.last

b.each_cons_pair do |u, v|
  ans += Math.min u, v
end

pp ans
