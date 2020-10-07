ans = 0
3.times do
  s,e = gets.to_s.split.map { |v| v.to_i }
  ans += s * e // 10
end

pp ans