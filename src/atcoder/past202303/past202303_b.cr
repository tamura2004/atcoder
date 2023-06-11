require "big"

d = gets.to_s.to_i64
s = gets.to_s.gsub(/\./,"").to_big_i
t = gets.to_s.gsub(/\./,"").to_big_i
u = (s + t).to_s
right = (("0" * d) + u)[-d,d]
left = u.size <= d ? "0" : u[0,u.size - d]

puts "#{left}.#{right}"
