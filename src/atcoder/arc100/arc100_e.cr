require "crystal/set_conv"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
b = a.map { |v| [v, 0_i64] }

def add(a,b)
  [a[0],a[1],b[0],b[1]].sort.last(2)
end

n.times do |i|
  (1<<n).times do |s|
    if s.bit(i) == 1
      b[s] = add(b[s], b[s ^ (1 << i)])
    end
  end
end

ans = 0_i64
b[1..].each do |(i, j)|
  chmax ans, i + j
  puts ans
end
