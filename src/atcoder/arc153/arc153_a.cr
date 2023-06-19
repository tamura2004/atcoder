n = gets.to_s.to_i64 + 99999
a, b, c, d, e, f = n.to_s.chars
ans = "#{a}#{a}#{b}#{c}#{d}#{d}#{e}#{f}#{e}"
puts ans
