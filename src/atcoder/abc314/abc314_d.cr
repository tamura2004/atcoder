n = gets.to_s.to_i
s = gets.to_s.chars
q = gets.to_s.to_i
qs = Array.new(q) do
  t, x, c = gets.to_s.split
  t = t.to_i
  x = x.to_i.pred
  {t, x, c[0]}
end.reverse

used = false
qs.select! do |t, x, c|
  case
  when t == 1
    true
  when used
    false
  else
    used = true
  end
end.reverse!

qs.each do |t, x, c|
  case t
  when 1
    s[x] = c
  when 2
    s = s.join.downcase.chars
  when 3
    s = s.join.upcase.chars
  end
end

puts s.join
