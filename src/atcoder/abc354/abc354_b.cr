n = gets.to_s.to_i64
sc = Array.new(n) do
  s, c = gets.to_s.split
  c = c.to_i64
  { s, c }
end.sort

i = sc.sum(&.last) % n
puts sc[i].first

