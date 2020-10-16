n,a,b = gets.to_s.split.map { |v| v.to_i }

if (b-a).even?
  puts "Alice"
else
  puts "Borys"
end
