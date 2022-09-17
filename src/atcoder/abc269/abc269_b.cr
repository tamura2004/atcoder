xs = [] of Int32
ys = [] of Int32

10.times do |y|
  s = gets.to_s
  10.times do |x|
    if s[x] == '#'
      xs << x
      ys << y
    end
  end
end

a, b = ys.minmax
c, d = xs.minmax

puts "#{a+1} #{b+1}"
puts "#{c+1} #{d+1}"