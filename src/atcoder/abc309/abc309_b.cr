n = gets.to_s.to_i64
a = Array.new(n){gets.to_s.chars.map(&.to_i)}

lt = a[0][0]

# up
(1...n).each do |y|
  a[y-1][0] = a[y][0]
end

# left
(1...n).each do |x|
  a[-1][x-1] = a[-1][x]
end

# dn
(1...n).reverse_each do |y|
  a[y][-1] = a[y-1][-1]
end

# right
(1...n).reverse_each do |x|
  a[0][x] = a[0][x-1]
end

a[0][1] = lt
puts a.map(&.join).join("\n")
