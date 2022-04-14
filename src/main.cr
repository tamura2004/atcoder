def g1(n)
  n.to_s.chars.map(&.to_i).sort.reverse.join.to_i
end

def g2(n)
  n.to_s.chars.map(&.to_i).sort.join.to_i
end

def f(n)
  g1(n) - g2(n)
end

n, k = gets.to_s.split.map(&.to_i64)

k.times do
  n = f(n)
end

pp n
