n = gets.to_s.to_i64
s = gets.to_s.gsub(/\./,"")
puts s == "|*|" ? :in : :out