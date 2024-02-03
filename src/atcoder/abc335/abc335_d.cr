require "crystal/matrix"

n = gets.to_s.to_i64
nz = n.x + n.y
seen = Matrix(String).new(nz, "")
seen[nz//2] = "T"

v = 1.y
z = 0.y
(1...n**2).each do |i|
  seen[z] = i.to_s
  z += v
  next if 0 <= z.x < n && 0 <= z.y < n && seen[z] == ""
  z -= v
  v *= -1.y
  z += v
end

puts seen.rows.map(&.join(" ")).join("\n")