a = Array.new(3) { gets.to_s.to_i64 }.sort
puts a.sum == a.last * 2 ? 1 : 0
