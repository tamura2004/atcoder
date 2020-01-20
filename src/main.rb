n = gets.to_i
a = gets.split(' ').map &:to_i
lcm = a.inject :lcm
ans = a.map{|e|lcm/e}.inject :+
ans %= 1000000007
p ans
