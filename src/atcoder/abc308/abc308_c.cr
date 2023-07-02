n = gets.to_s.to_i64
ab = Array.new(n) do |i|
  a, b = gets.to_s.split.map(&.to_i64)
  {a, b, i + 1}
end

ab.sort! do |x, y|
  a1, b1, i1 = x
  a2, b2, i2 = y
  {a1 * (a2 + b2), -i1} <=> {a2 * (a1 + b1), -i2}
end

puts ab.reverse.map(&.last).join(" ")
