require "crystal/indexable"
n = gets.to_s.to_i64
a = Array.new(n){gets.to_s}.tally
puts  a["For"] <= n // 2 ? :No : :Yes