n = gets.to_s.to_i64
seen = Set(Int64).new

ans = 0_i64
n.times do
  a = gets.to_s.to_i64
  ans += 1 if a.in?(seen)
  seen << a
end

pp ans
