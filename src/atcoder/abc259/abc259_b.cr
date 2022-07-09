x,y,d = gets.to_s.split.map(&.to_i64)

th = d * Math::PI / 180
xx = x * Math.cos(th) - y * Math.sin(th)
yy = x * Math.sin(th) + y * Math.cos(th)

puts "#{xx} #{yy}"