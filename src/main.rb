def combi(n,m)
  (1..m).inject(1){ |acc,i| acc = acc * (n - m + i) / i }
end

def f(n,m)
  combi(n+m,m)
end

def g(n,m)
  f(n + 1, m + 1) - 1
end

r1,c1,r2,c2 = gets.split.map &:to_i

a = g(r2, c2)
b = g(r1 - 1, c2)
c = g(r2, c1 - 1)
d = g(r1 - 1, c1 - 1)

puts (a - b - c + d) % 1000000007