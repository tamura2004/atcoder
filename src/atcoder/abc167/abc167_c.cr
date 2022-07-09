n,m,x = gets.to_s.split.map(&.to_i64)
c = [] of Int64

a = Array.new(n) do
  ca = gets.to_s.split.map(&.to_i64)
  c << ca.shift
  ca
end

ans = (1<<n).times.min_of do |s|
  learn = Array.new(m, 0_i64)
  cost = 0_i64
  n.times do |i|
    next if s.bit(i).zero?
    cost += c[i]
    m.times do |j|
      learn[j] += a[i][j]
    end
  end
  learn.min >= x ? cost : Int64::MAX
end

puts ans == Int64::MAX ? -1 : ans

