N,M = gets.split.map &:to_i
G = Array.new(N){[]}
M.times do
  a,b = gets.split.map &:to_i
  G[a-1] << b-1
  G[b-1] << a-1
end

P = [0] # パリティ
S = [0] # スタック

while S.size > 0
  i = S.pop 
  G[i].each do |j|
    if P[j].nil?
      P[j] = 1 - P[i]
      S << j
    elsif P[i] == P[j]
      puts N * (N - 1) / 2 - M
      exit
    end
  end
end

puts P.count(0) * P.count(1) - M