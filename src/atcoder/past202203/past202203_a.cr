a, b, c = gets.to_s.split.map(&.to_i64)
x,y = [a, b, c].combinations(2).map { |(x, y)| x*y }.minmax
puts "#{x} #{y}"
