x1,x2,y1,y2 = gets.to_s.split.map { |v| v.to_i }
ans = (y2-y1).gcd(x2-x1) + 1
puts ans