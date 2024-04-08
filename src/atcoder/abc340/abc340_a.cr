a,b,c = gets.to_s.split.map(&.to_i64)
puts a.step(by: c, to: b).to_a.join(" ")
