class Graph
  getter n : Int32
  getter g : Array(Array(Int64))
  delegate "[]", to: g

  def initialize(@n)
    @g = Array.new(n){Array.new(n, 0_i64)}
  end

  def add(v, nv)
    g[v][nv] += 1
  end

  def has_cycle?(a)
    n = a.size
    n.times.all? do |i|
      g[a[i-1]][a[i]] > 0
    end
  end

  def delete_cycle!(a)
    n = a.size
    n.times do |i|
      g[a[i-1]][a[i]] -= 1
    end
  end
end

# g = Graph.new(4)
# g.add 0, 1
# g.add 1, 2
# g.add 2, 0

# pp! g
# pp! g.has_cycle?([0,1,2])
# pp! g.delete_cycle!([0,1,2])
# pp! g

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i.pred)
g = Graph.new(4)

a.zip(a.sort).each do |y, x|
  g[y][x] += 1
end

ans = 0_i64
(2..4).each do |len|
  [0,1,2,3].each_permutation(len) do |p|
    if g.has_cycle?(p)
      pp! [len, p]
      g.delete_cycle!(p)
      ans += len - 1
    end
  end
end
pp ans
