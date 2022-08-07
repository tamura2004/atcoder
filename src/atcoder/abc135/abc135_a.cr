a, b = gets.to_s.split.map(&.to_i64)
quit "IMPOSSIBLE" if (a + b).odd?
puts (a + b)//2
