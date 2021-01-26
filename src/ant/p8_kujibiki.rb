n, m = gets.to_s.split.map { |v| v.to_i }
k = gets.to_s.split.map { |v| v.to_i }
ans = k.repeated_combination(4).any? do |a|
  a.sum == m
end
puts ans ? "Yes" : "No"
