require "crystal/inversion_number"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i.pred)
inv = a.inversion_number

quit :No if inv.odd?

ans = [] of Tuple(Int32,Int32)

n.times do |i|
  next if a[i] == i
  j = a.index(i, i+1).not_nil!
  ans << {j+1, i}
  a = solve(a, i, j, n)
end

puts :Yes
puts ans.size
puts ans.map(&.join(" ")).join("\n")

def solve(a, i, j, n)
  x, y, z, w = a[...i], a[i...j], a[j...j+2], a[j+2..]
  x + z + y + w
end
