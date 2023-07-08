t = gets.to_s.to_i64
t.times do
  n = gets.to_s.to_i64
  s = gets.to_s
  ans = (1..n-1).any? do |i|
    s[...i] < s[i..]
  end
  puts ans ? :Yes : :No
end

