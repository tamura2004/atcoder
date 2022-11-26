n = gets.to_s.to_i64
g = Hash(Int32,Array(Int32)).new do |h,k|
  h[k] = [] of Int32
end

n.times do
  v, nv = gets.to_s.split.map(&.to_i)
  g[v] << nv
  g[nv] << v
end

ans = 1
seen = [ans].to_set
q = Deque.new([ans])

while q.size > 0
  v = q.shift
  g[v].each do |nv|
    next if nv.in?(seen)
    seen << nv
    q << nv
    chmax ans, nv
  end
end

pp ans
