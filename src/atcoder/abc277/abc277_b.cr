n = gets.to_s.to_i64
seen = Set(String).new

A = "HDCS".chars
B = "A23456789TJQK".chars

n.times do
  s = gets.to_s
  quit "No" unless s[0].in?(A) && s[1].in?(B)
  quit "No" if s.in?(seen)
  seen << s
end

puts "Yes"
