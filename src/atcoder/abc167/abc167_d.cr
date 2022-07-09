n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i.pred)

nex = Array.new(60) { Array.new(n, -1) }
n.times { |i| nex[0][i] = a[i] }

(1...60).each do |i|
  n.times do |j|
    nex[i][j] = nex[i-1][nex[i-1][j]]
  end
end

j = 0
60.times do |i|
  next if k.bit(i).zero?
  j = nex[i][j]
end

pp j + 1
