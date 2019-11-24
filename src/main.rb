N = gets.to_i
G = Array.new(N){[]} # 隣接リスト
C = Array.new(N,0) # 辺の色 2**Nビット
CL = [] #　辺の色リスト

def rzero(n)
  c = 0
  loop do
    n,r = n.divmod(2)
    break if r == 0
    c += 1
  end
  return c
end

(N-1).times do |i|
  a,b = gets.split.map{|v|v.to_i - 1}
  color = rzero(C[a]|C[b])
  CL << color + 1
  C[a] |= 1<<color
  C[b] |= 1<<color
  G[a] << b
  G[b] << a
end

puts G.map(&:size).max
puts CL
