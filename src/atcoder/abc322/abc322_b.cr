n, m = gets.to_s.split.map(&.to_i64)
s = gets.to_s.chars
t = gets.to_s.chars

if t.first(n) == s
  if t.last(n) == s
    pp 0
  else
    pp 1
  end
else
  if t.last(n) == s
    pp 2
  else
    pp 3
  end
end
