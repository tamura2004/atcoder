require "crystal/prime"

t = gets.to_s.to_i64
t.times do
  n = gets.to_s.to_i64
  pd = n.prime_division
  puts pd.keys.size > 1 ? "Yes" : "No"
end
