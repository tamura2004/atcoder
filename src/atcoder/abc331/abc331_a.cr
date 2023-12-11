mm,dd = gets.to_s.split.map(&.to_i64)
y,m,d = gets.to_s.split.map(&.to_i64)

d += 1
if dd < d
  m += 1
  d = 1
end

if mm < m
  y += 1
  m = 1
end

puts [y,m,d].join(" ")