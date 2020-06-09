class Station
  property :ans

  def initialize
    @ans = 0_i64
    @g = Hash(Int64, Int64).new { |h, k| h[k] = 0_i64 }
  end

  def <<(a)
    @ans += @g[2540_i64 - a]
    @g[a] += 1_i64
  end
end

n, m = gets.not_nil!.split.map(&.to_i64)
g = Array.new(n) { Station.new }
m.times do
  a, b, c = gets.not_nil!.split.map(&.to_i)
  a -= 1
  b -= 1
  g[a] << c.to_i64
  g[b] << c.to_i64
end

ans = g.map(&.ans).sum
puts ans
