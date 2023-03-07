n, m = gets.to_s.split.map(&.to_i64)
ans = true
seen = Set(Tuple(Int32,Int32)).new

m.times do
  v, nv = gets.to_s.split.map(&.to_i).sort
  ans = false if v == nv
  ans = false unless 1 <= v <= n
  ans = false unless 1 <= nv <= n
  ans = false if seen.includes?({v,nv})
  seen << {v, nv}
end

puts ans ? "Yes" : "No"
