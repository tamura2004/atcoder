n = gets.to_s.to_i64
s = gets.to_s
seen = Array.new(3, false)
n.times do |i|
  case s[i]
  when 'A'
    seen[0] = true
  when 'B'
    seen[1] = true
  when 'C'
    seen[2] = true
  end
  if seen.all?
    quit i + 1
  end
end
