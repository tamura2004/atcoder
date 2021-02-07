class PriorityQueue(T)
  getter f : T, T -> Bool
  getter a : Deque(T)

  def initialize(&block : T, T -> Bool)
    @f = block
    @a = Deque(T).new
  end

  def initialize
    @f = ->(a : T, b : T) { a < b }
    @a = Deque(T).new
  end

  def <<(v : T)
    @a << v
    fixup(a.size - 1)
  end

  def pop : T
    ret = a[0]
    last = a.pop
    if a.size > 0
      a[0] = last
      fixdown
    end
    ret
  end

  private def fixup(i : Int32)
    j = up(i)
    while i > 0 && comp j, i
      a.swap i, j
      i, j = j, up(j)
    end
  end

  private def fixdown
    i = 0
    while lo(i) < a.size
      if hi(i) < a.size && comp lo(i), hi(i)
        j = hi(i)
      else
        j = lo(i)
      end
      break if comp j, i
      a.swap i, j
      i = j
    end
  end

  @[AlwaysInline]
  private def comp(i, j)
    f.call a[i], a[j]
  end

  @[AlwaysInline]
  private def lo(i)
    i * 2 + 1
  end

  @[AlwaysInline]
  private def hi(i)
    i * 2 + 2
  end

  @[AlwaysInline]
  private def up(i)
    (i - 1) // 2
  end

  delegate :size, to: @a
end

INF = Int64::MAX

class Graph
  alias Edge = Tuple(Int32, Int64)
  getter n : Int32
  getter g : Array(Array(Edge))
  delegate "[]", to: @g

  def initialize(@n)
    @g = Array.new(n) { [] of Edge }
  end

  def reverse
    Graph.new(n).tap do |ans|
      n.times do |v|
        g[v].each do |nv, cost|
          ans[nv] << {v, cost}
        end
      end
    end
  end

  # from 1-indexed
  def add_edge(a, b, c)
    g[(a - 1).to_i] << {(b - 1).to_i, c.to_i64}
  end

  def dijkstra(init)
    q = PriorityQueue(Edge).new { |a, b| a.last > b.last }
    g[init].each do |v, cost|
      q << {v, cost}
    end
    seen = Array.new(n, false)

    while q.size > 0
      v, cost = q.pop
      return cost if v == init
      next if seen[v]
      seen[v] = true
      g[v].each do |nv, ncost|
        next if seen[nv]
        q << {nv, cost + ncost}
      end
    end
    return INF
  end
end

def solve(io)
  n, m = io.gets.to_s.split.map { |v| v.to_i }
  g = Graph.new(n)
  m.times do
    a, b, c = io.gets.to_s.split.map { |v| v.to_i64 }
    g.add_edge(a, b, c)
  end

  n.times.map do |i|
    cnt = g.dijkstra(i)
  end.to_a
end

def solve2(io)
  n, m = io.gets.to_s.split.map { |v| v.to_i }
  g = Graph.new(n)
  s = Array.new(n, INF)
  m.times do
    a, b, c = io.gets.to_s.split.map { |v| v.to_i64 }
    if a == b
      s[a - 1] = Math.min s[a - 1], c
    else
      g.add_edge(a, b, c)
    end
  end

  n.times.map do |i|
    if s[i] != INF
      s[i]
    else
      ans = g.dijkstra(i)
    end
  end.to_a
end

s = <<-EOS
4 7
1 2 10
2 3 30
1 4 15
3 4 25
3 4 20
4 3 20
4 3 30
EOS

10.times do
  n = 5
  m = 15
  a = ["#{n} #{m}"]
  m.times do
    a << [rand(n)+1,rand(n)+1,rand(10)+1].join(" ")
  end
  s = a.join("\n")
  want = solve(IO::Memory.new(s))
  got = solve2(IO::Memory.new(s))
  if want != got
    pp want
    pp got
    puts s
    exit
  end
end

