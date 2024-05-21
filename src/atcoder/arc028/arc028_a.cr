n, a, b = gets.to_s.split.map(&.to_i64)

cnt = n.pred % (a + b)
puts cnt < a ? "Ant" : "Bug"