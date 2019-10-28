N = gets.to_i
M = 10**9+7

p = 1
N.times do |i|
  p *= i+1
  p %= M
end

puts p