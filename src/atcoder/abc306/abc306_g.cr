class Graph
  getter g : Array(Array(Int32))
  getter n : Int32
  delegate "[]", to: g

  def initialize(@n)
    @g = Array.new(n){[] of Int32}
  end

  def add(v, nv, both = true, origin = 1)
    v -= origin
    nv -= origin
    g[v] << nv
  end
end

struct Int
  def to_g
    Graph.new(self)
  end
end

class SCC
  getter g : Graph
  getter rg : Graph
  delegate n, to: g
  getter seen : Array(Bool)
  getter seen_rev : Array(Bool)

  def initialize(@g,@rg)
    @seen = Array.new(n, false)
    @seen_rev = Array.new(n, false)
  end

  def solve
    ans = n.to_g

    # 頂点0から正順で辿り着ける頂点をマーク
    seen[0] = true
    q = Deque.new([0])
    while q.size > 0
      v = q.shift
      g[v].each do |nv|
        next if seen[nv]
        seen[nv] = true
        q << nv
      end
    end

    # 逆順
    q << 0
    seen_rev[0] = true
    while q.size > 0
      v = q.shift
      rg[v].each do |nv|
        if seen[nv]
          ans.add nv, v, both: false, origin: 0
        end

        next if seen_rev[nv]
        seen_rev[nv] = true
        q << nv
      end
    end
    ans
  end
end

t = gets.to_s.to_i64
t.times do |times|
  n, m = gets.to_s.split.map(&.to_i)
  g = n.to_g
  rg = n.to_g

  m.times do
    v, nv = gets.to_s.split.map(&.to_i)
    g.add v, nv, both: false
    rg.add nv, v, both: false
  end

  sg = SCC.new(g,rg).solve

  puts Problem.new(sg).solve ? "Yes" : "No"
end

# 有向グラフの全域木の深さ
class Depth
  getter g : Graph
  getter depth : Array(Int32)
  delegate n, to: g

  def initialize(@g)
    @depth = Array.new(n, Int32::MAX)
  end

  def solve
    q = Deque.new([0])
    depth[0] = 0_i64
    while q.size > 0
      v = q.shift
      g[v].each do |nv|
        next unless depth[nv] == Int32::MAX
        depth[nv] = depth[v] + 1
        q << nv
      end
    end
    depth
  end
end

# 頂点１を含む強連結成分で考える
# １を頂点とする適当な全域木を作り、頂点からの深さを求めておく
# 木に１辺を加えたものが
class Problem
  getter g : Graph
  getter depth : Array(Int32)
  delegate n, to: g

  def initialize(@g)
    @depth = Depth.new(g).solve
  end

  def solve
    ans = 0
    n.times do |v|
      g[v].each do |nv|
        ans = ans.gcd((depth[v] + 1 - depth[nv]).abs)
      end
    end

    while ans.divisible_by?(5)
      ans //= 5
    end
    
    while ans.divisible_by?(2)
      ans //= 2
    end

    ans == 1
  end
end
