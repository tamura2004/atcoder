n = gets.to_s.to_i64
ans = (1..n).map{|i| i % 3 == 0 ? "x" : "o"}.join
puts ans