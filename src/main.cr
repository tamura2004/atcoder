n,m = read_line.split.map &.to_i
a = Array.new(n){ read_line.split.map &.to_i }.transpose.map{|v|v.join.to_i(2)}

# p a.size

ans = 0
0.upto(2**n-1) do |bit|
  b = a.map{|v| v ^ bit}.map{|v| v.popcount }.map{|v| v > n - v ? v : n - v}.sum
  ans = b if ans < b
end
puts ans