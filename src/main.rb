n,h = gets.to_s.split.map{ |v| v.to_i }
a = gets.to_s.split.map{ |v| v.to_i.abs }

a.each do |v|
  h /= h.gcd(v)
end

puts h == 1 ? "YES" : "NO"
