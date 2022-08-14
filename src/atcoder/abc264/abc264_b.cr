require "crystal/complex"

center = 8.x + 8.y
r, c = gets.to_s.split.map(&.to_i64)
ans = (center - (r.x + c.y)).chebi

if ans.odd?
  puts "black"
else
  puts "white"
end
