class SegmentTree(T)
  getter n : Int32
  getter f : T?, T? -> T?
  getter node : Array(T?)

  def initialize(v)
    initialize(v) { |a, b| a < b ? a : b }
  end

  def initialize(v, &block : T, T -> T)
    @f = ->(a : T?, b : T?) {
      a && b ? block.call(a, b) : a ? a : b ? b : nil
    }

    @n = ceil_pow2(v.size)
    @node = Array(T?).new(2 * n - 1, nil)

    v.size.times do |i|
      node[i + n - 1] = v[i]
    end

    (n - 2).downto(0) do |i|
      node[i] = f.call(node[2*i + 1], node[2*i + 2])
    end
  end

  def update(i, x)
    i += n - 1
    node[i] = x
    while i > 0
      i = (i - 1) // 2
      node[i] = f.call(node[2*i + 1], node[2*i + 2])
    end
  end

  def []=(i, x)
    update(i, x)
  end

  def get(a : Int32, b : Int32, k = 0, lo = 0, hi = -1) : T?
    hi = n if hi < 0
    case
    when hi <= a || b <= lo then nil
    when a <= lo && hi <= b then node[k]
    else
      vlo = get(a, b, 2*k + 1, lo, (lo + hi)//2)
      vhi = get(a, b, 2*k + 2, (lo + hi)//2, hi)
      f.call(vlo, vhi)
    end
  end

  def [](r : Range(Int32, Int32))
    a = r.begin
    b = r.end + (r.exclusive? ? 0 : 1)
    get(a, b)
  end

  private def ceil_pow2(n)
    1 << Math.log2(n).ceil.to_i
  end

  delegate call, to: f
end

alias Pair = Tuple(Int32, Int32)

class Graph
  getter n : Int32
  property g : Array(Array(Int32))
  getter path : Array(Int32)
  getter depth : Array(Int32)
  getter id : Array(Int32)

  delegate "[]", to: g

  def initialize(@n)
    @g = Array.new(n) { [] of Int32 }
    @path = [] of Int32
    @depth = [] of Int32
    @id = Array.new(n, -1)
  end

  def euler_tour
    i = 0
    dfs(0) do |v, d|
      v = ~v if v < 0
      path << v
      depth << d
      id[v] = i if id[v] == -1
      i += 1
    end
  end

  def dfs(root)
    que = Deque(Pair).new
    que << Pair.new(~root, 0)
    que << Pair.new(root, 0)
    seen = Array.new(n, false)
    seen[0] = true
    while que.size > 0
      v, depth = que.pop
      yield v, depth
      next if v < 0
      g[v].each do |nv|
        next if seen[nv]
        seen[nv] = true
        que << Pair.new(~v, depth)
        que << Pair.new(~nv, depth + 1)
        que << Pair.new(nv, depth + 1)
      end
    end
  end
end

{% if env("DEBUG") %}
  require "debug"
  require "../lib/crystal/test_helper"
  include Random::Secure
{% else %}
  macro debug!(content)
  end
{% end %}

class Problem
  getter n : Int32
  getter g : Graph
  getter q : Array(Pair)
  getter rmq : SegmentTree(Int32)

  def initialize(@n, @g, @q)
    g.euler_tour
    @rmq = SegmentTree(Int32).new(g.depth)
  end

  def self.read
    n = gets.to_s.to_i
    g = Graph.new(n)
    (n - 1).times do
      a, b = gets.to_s.split.map { |v| v.to_i - 1 }
      g[a] << b
      g[b] << a
    end
    m = gets.to_s.to_i
    q = Array.new(m) do
      a, b = gets.to_s.split.map { |v| v.to_i - 1 }
      Pair.new(a, b)
    end
    new(n, g, q)
  end

  def solve
    q.each do |(a,b)|
      u = g.id[a]
      v = g.id[b]
      u, v = v, u if u > v

      if lca_depth = rmq[u..v]
        ans = g.depth[u] + g.depth[v] - lca_depth * 2 + 1
        puts ans
      else
        raise "error"
      end
    end
  end

  def run
    solve
  end
end

n = 10
g = Graph.new(n)
g.g = Test::Tree.new(n).rand.g
q = [Pair.new(0,n-1)]
Problem.new(n, g, q).run
