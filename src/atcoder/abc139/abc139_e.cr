alias V = Tuple(Int32,Int32)

def f(t)
  return t if t[0] < t[1]
  {t[1],t[0]}
end

n = gets.to_s.to_i
g = Hash(V, Array(V)).new

(1..n).each do |i|
  (1..n).each do |j|
    next unless i < j
    g[f({i,j})] = [] of V
  end
end

(1..n).each do |i|
  gets.to_s.split.map(&.to_i).each_cons_pair do |j,k|
    v = f({i,j})
    nv = f({i,k})
    g[v] << nv
  end
end

ind = Hash(V,Int32).new
day = Hash(V,Int32).new
g.keys.each do |v|
  ind[v] = 0
  day[v] = -1
end

g.keys.each do |v|
  g[v].each do |nv|
    ind[nv] += 1
  end
end

q = Deque(V).new
ind.each do |k,v|
  q << k if v.zero?
  day[k] = 1 if v.zero?
end

while q.size > 0
  v = q.shift
  g[v].each do |nv|
    ind[nv] -= 1
    if ind[nv].zero?
      day[nv] = day[v] + 1
      q << nv
    end
  end
end

if ind.values.all?(&.zero?)
  pp day.values.max
else
  pp -1
end
