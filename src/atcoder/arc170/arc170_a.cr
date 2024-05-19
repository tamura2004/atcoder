n = gets.to_s.to_i64
s = gets.to_s.chars.map { |c| c == 'A' ? 1 : -1 }
t = gets.to_s.chars.map { |c| c == 'A' ? 1 : -1 }

d = (0..n).map do |i|
  { t[i], i, s[i] }
end

pp d