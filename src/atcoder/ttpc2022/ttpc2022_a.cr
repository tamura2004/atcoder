require "crystal/prime"

x, y = gets.to_s.split.map(&.to_i64)
gcd = (x-2015).gcd(y-2015)
puts gcd.factors.sort.join("\n")
