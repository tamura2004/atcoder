require "crystal/ext_gcd"

# |ad - bc| = 2s

a, b = gets.to_s.split.map(&.to_i64)
d, c, g = ext_gcd(a, -b)

pp! [d,c,g]

quit -1 if g.abs > 2

if g.abs == 2
  puts "#{c} #{d}"
else
  puts "#{c*2} #{d*2}"
end
