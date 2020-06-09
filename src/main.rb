INF = 10**12
n,m = gets.split.map(&:to_i)
e = Array.new(m){ gets.split.map(&:to_i) }.map{|a,b,c|[a-1,b-1,c]}
g = Array.new(n){ Array.new(n, INF) }
n.times { |i| g[i][i] = 0 }

e.each do |a,b,c|
  g[a][b] = c
  g[b][a] = c
end

n.times do |k|
  n.times do |i|
    n.times do |j|
      dist = g[i][k] + g[k][j]
      g[i][j] = dist if g[i][j] > dist
    end
  end
end

ans = 0
e.each do |i,j,cost|
  ans += 1 if g[i][j] < cost
end

puts ans
