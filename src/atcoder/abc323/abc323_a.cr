s = gets.to_s.chars.each_slice(2)
ans = s.all?(&.[1].== '0')
puts ans ? "Yes" : "No"