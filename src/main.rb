N,M,L = gets.split.map &:to_i
INF = 1_000_000_001
G = Array.new(N){|i| Array.new(N){|j| i == j ? 0 : INF}}
M.times do |i|
  a,b,c = gets.split.map &:to_i
  a -= 1; b -= 1
  G[a][b] = c
  G[b][a] = c
end

N.times do |k|
  N.times do |i|
    N.times do |j|
      len = G[i][k] + G[k][j]
      G[i][j] = len if len < G[i][j]
    end
  end
end

H = Array.new(N){|i| Array.new(N){|j| i==j ? 0 : (G[i][j] <= L ? 1 : INF)}}
N.times do |k|
  N.times do |i|
    N.times do |j|
      len = H[i][k] + H[k][j]
      H[i][j] = len if len < H[i][j]
    end
  end
end

Q = gets.to_i
Q.times do
  a,b = gets.split.map &:to_i
  a -= 1; b -= 1
  ans = H[a][b]
  if ans == INF
    puts -1
  else
    puts ans - 1
  end
end


