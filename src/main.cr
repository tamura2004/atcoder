a,b,c=gets.to_s.split.map(&.to_i)
puts b.zero? && a == c ? "?" : a + b == c ? "+" : a - b == c ? "-" : "!"
