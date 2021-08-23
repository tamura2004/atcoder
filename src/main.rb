n, m = gets.to_s.split.map { |v| v.to_i }
g = Array.new(n) { [] }

m.times do
  v, nv, w = gets.to_s.split.map { |v| v.to_i }
  v -= 1
  nv -= 1
  g[v] << [nv, w]
  g[nv] << [v, w]
end

z = Array.new(n, 0)
u = Array.new(n, 0)

z[0] = 0
u[0] = 1

f = ->(v, pv) do
  g[v].each do |nv, w|
    next if nv == pv
    z[nv] = w - z[v]
    u[nv] = w - u[v]
    f.call(nv, v)
  end
end
f.call(0, -1)

g = ->(v, nv, x) do
  len = (x - z[v]) / (u[v] - z[v])
  (u[nv] - z[nv]) * len + z[nv]
end

pp g.call(0, 2, 15)
pp g.call(0, 1, 15)
pp g.call(0, 3, 15)
