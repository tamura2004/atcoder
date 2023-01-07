n = gets.to_s.to_i64
a = Array.new(n){gets.to_s}
puts a.reverse.join("\n")