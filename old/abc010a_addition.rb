N = gets.to_i
A = gets.split.map(&:to_i)
S = A.inject(:+)

puts S.even? ? "YES" : "NO"
