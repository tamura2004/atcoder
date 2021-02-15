require "matrix"
x, y = gets.to_s.split.map { |v| v.to_i }
m = Matrix[[3, 1], [1, 3]]
v = m.inv * Vector[x, y]
puts v.all? { |a| a.to_i == a } ? "Yes" : "No"
