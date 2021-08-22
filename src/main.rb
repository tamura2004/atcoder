n, m = gets.to_s.split.map { |v| v.to_i }
s, t = m.times.map do
  gets.to_s.split.map { |v| v.to_i - 1 }
end.transpose

ix = [nil] * m
m.times do |i|
  ix[s[i]] = i
end

# 依存関係のグラフ、hは入次数
g = m.times.map { [] }
h = [0] * m

m.times do |v|
  nv = ix[t[v]]
  next if nv.nil?
  g[v] << nv
  h[nv] += 1
end

# 入次数0の頂点をキューに
q = []
m.times do |v|
  if h[v] == 0
    q << v
  end
end

# トポロジカルソート、ansは結果
ans = []
while q.size > 0
  v = q.shift
  ans << v
  g[v].each do |nv|
    h[nv] -= 1
    if h[nv] == 0
      q << nv
    end
  end
end

puts ans.size == m ? "No" : "Yes"
