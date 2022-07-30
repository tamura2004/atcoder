n = gets.to_s.to_i
puts n * 2

q,r = n.divmod(4)
if r.zero?
  puts "4" * q
else
  puts r.to_s + "4" * q
end