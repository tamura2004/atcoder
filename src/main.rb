n, k = gets.split.map(&:to_i)
s = 0
2.upto(n) { s += s / ~-k + 1 }
p s

pp k
pp -k
pp ~-k
