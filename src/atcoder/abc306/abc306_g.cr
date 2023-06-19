require "crystal/graph"

class Problem
  class Seen
    getter g : Graph
    delegate n, to: g
    getter seen : Array(Bool)

    def initialize(@g)
      @seen = Array.new(n, false)
    end

    def solve
      q = Deque.new([0])
      seen[0] = true
      while q.size > 0
        v = q.shift
        g.each(v) do |nv|
          next if seen[nv]
          seen[nv] = true
          q << nv
        end
      end
      seen
    end
  end

  class Depth
    getter g : Graph
    delegate n, to: g
    getter seen : Array(Bool)

    def initialize(@g, @seen)
    end

    def solve
      depth = Array.new(n, Int32::MAX//4)
      depth[0] = 0
      seen[0] = true
      q = Deque.new([0])
      while q.size > 0
        v = q.shift
        g.each(v) do |nv|
          next if seen[nv]
          seen[nv] = true
          depth[nv] = depth[v] + 1
          q << nv
        end
      end
      depth
    end
  end

  getter g : Graph
  getter rg : Graph
  getter seen : Array(Bool)
  delegate n, to: g

  def initialize(@g,@rg)
    seen_g = Seen.new(g).solve
    seen_rg = Seen.new(rg).solve
    @seen = Array.new(n) do |i|
      !seen_g[i] || !seen_rg[i]
    end
  end

  def solve
    depth = Depth.new(g, seen).solve

    gcd = 0
    g.each do |v|
      next if depth[v] == Int32::MAX//4
      g.each(v) do |nv|
        next if depth[nv] == Int32::MAX//4
        gcd = gcd.gcd((depth[v] + 1 - depth[nv]).abs)
      end
    end

    gcd
  end
end

t = gets.to_s.to_i64
t.times do
  n, m = gets.to_s.split.map(&.to_i64)
  g = n.to_g
  rg = n.to_g

  m.times do
    v, nv = gets.to_s.split.map(&.to_i64)
    g.add v, nv, both: false
    rg.add nv, v, both: false
  end

  cnt = Problem.new(g,rg).solve
  if cnt.zero?
    puts "No"
  else
    while cnt.divisible_by?(2)
      cnt //= 2
    end
    while cnt.divisible_by?(5)
      cnt //= 5
    end
    puts cnt == 1 ? "Yes" : "No"
  end
end