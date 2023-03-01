def solve(s)
  m = s.count('1')
  return -1 if m.odd?
  return m//2 if m != 2
  solve2(s)
end

def solve2(s)
  return 1 if s =~ /10+1/
  return 2 if s =~ /1100/
  return 2 if s =~ /0011/
  return 3 if s =~ /0110/
  -1
end

t = gets.to_s.to_i
t.times do
  n = gets.to_s.to_i64
  s = gets.to_s
  pp solve(s)
end
