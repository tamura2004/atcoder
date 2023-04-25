require "crystal/graph"

n,m = gets.to_s.split.map(&.to_i64)
g = n.to_g

m.times do
  g.read
end

k = gets.to_s.to_i64
pd = Array.new(k) do
  p, d = gets.to_s.split.map(&.to_i)
  p -= 1
  {p, d}
end

BLACK = 1
WHITE = 0

class Fill
  getter g : Graph
  getter pd : Array(Tuple(Int32,Int32))
  getter seen : Array(Bool)
  getter colors : Array(Int32)
  delegate n, to: g

  def initialize(@g, @pd)
    @seen = Array.new(n, false)
    @colors = Array.new(n, BLACK)
  end

  def solve
    pd.each do |p, d|
      next if d.zero?
      @seen = Array.new(n, false)
      q = Deque(Tuple(Int32,Int32)).new
      q << {p, d-1}
      while q.size > 0
        v, d = q.shift
        colors[v] = WHITE
        g.each(v) do |nv|
          next if seen[nv]
          seen[nv] = true
          next if d.zero?
          q << {nv, d - 1}
        end
      end
    end
    colors
  end
end

colors = Fill.new(g, pd).solve

class Check
  getter g : Graph
  getter pd : Array(Tuple(Int32,Int32))
  getter seen : Array(Bool)
  getter colors : Array(Int32)
  delegate n, to: g

  def initialize(@g, @pd, @colors)
    @seen = Array.new(n, false)
  end

  def solve
    pd.all? do |p, d|
      bfs(p, d)
    end
  end

  def bfs(p, d)
    @seen = Array.new(n, false)
    q = Deque(Tuple(Int32,Int32)).new
    q << {p, d}
    while q.size > 0
      v, d = q.shift
      return true if d.zero? && colors[v] == BLACK
      g.each(v) do |nv|
        next if seen[nv]
        seen[nv] = true
        q << {nv, d-1}
      end
    end
    false
  end
end

ans = Check.new(g, pd,colors).solve
if ans
  puts :Yes
  puts colors.join
else
  puts :No
end