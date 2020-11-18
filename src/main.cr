n,m = gets.to_s.split.map { |v| v.to_i }
st = Array.new(m){ gets.to_s.split.map { |v| v.to_i - 1} }
imos = Array.new(n+1, 0)

st.each do |(s,t)|
  imos[s] += 1
  imos[t+1] -= 1
end

n.times do |i|
  imos[i+1] += imos[i]
end

rmq = SqrtDecompositionRMQ.new(n)
n.times do |i|
  rmq[i] = imos[i]
end

cnt = 0
ans = [] of Int32
m.times do |i|
  s,t = st[i]
  # pp! rmq
  if k = rmq[s,t]
    if k >= 2
      cnt += 1
      ans << i + 1
    end
  end
end

puts cnt
ans.each do |i|
  puts i
end

class SqrtDecompositionRMQ
  N = 512
  INF = Int32::MAX

  getter n : Int32
  getter m : Int32
  getter a : Array(Int32)
  getter b : Array(Int32)

  def initialize(@n)
    @m = (n + N - 1) // N
    @a = Array.new(m * N, INF)
    @b = Array.new(m, INF)
  end

  def []=(i, x)
    a[i] = x
    j = i // N
    b[j] = a[j * N, N].min
  end

  def [](i, j)
    m.times.min_of do |k|
      lo = k * N
      hi = (k + 1) * N
      next INF if j < lo || hi <= i
      next b[k] if i <= lo && hi <= j
      a[Math.max(i, lo)..Math.min(j, hi)].min
    end
  end
end