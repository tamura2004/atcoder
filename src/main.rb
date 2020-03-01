# ABC157D
# no block

n,m,k = gets.split.map &:to_i
G = Array.new(n){ [] }
V = Array.new(n){ 1 }

m.times do
  a,b = gets.split.map &:to_i
  a -= 1; b -= 1
  G[a] << b
  G[b] << a
  V[a] += 1
  V[b] += 1
end
COLOR = Array.new(n){ -1 }
color = 1

n.times do |i|
  next if COLOR[i] != -1
  COLOR[i] = color
  que = [i]
  while !que.empty?
    v = que.shift
    G[v].each do |nv|
      next if COLOR[nv] != -1
      COLOR[nv] = color
      que << nv
    end
  end
  color += 1
end

NUM = Array.new(color){ 0 }
COLOR.each do |c|
  NUM[c] += 1
end

ans = n.times.map{|i| NUM[COLOR[i]] - V[i]}
puts ans.join(" ")