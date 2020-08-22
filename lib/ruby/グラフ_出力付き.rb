require "ruby-graphviz"

# 無向グラフ
class Graph
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize(n,pairs)
    @n = n
    @g = Array.new(n){ [] }
    pairs.each do |a,b|
      g[a] << b
      g[b] << a
    end
  end

  def [](v)
    g[v]
  end

  def to_png
    gv = GraphViz.new(:G, type: :digraph)
    nodes = Array.new(n, nil)
    n.times do |v|
      nodes[v] = gv.add_nodes(v.to_s)
    end
    n.times do |v|
      g[v].each do |nv|
        gv.add_edges(nodes[v],nodes[nv])
      end
    end
    gv.output(png: "#{Time.now.strftime('%H%M%S')}.png") 
  end
end

# 有向グラフ
class DiGraph < Graph
  def initialize(n,pairs)
    super(n,pairs)
    @h = @g.dup
    @g = Array.new(n){ [] }
    seen = Array.new(n, false)
    que = [0]
    seen[0] = true
    while que.size > 0
      v = que.shift
      h[v].each do |nv|
        next if seen[nv]
        seen[nv] = true
        g[v] << nv
        que << nv
      end
    end
  end
end

class Problem
  MOD = 10**9+7
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize
    @n = gets.to_s.to_i
    @pairs = Array.new(n-1){ gets.split.map(&:to_i).map{ _1 - 1 } }
    @g = DiGraph.new(@n,@pairs)
    @white = Array.new(n,nil)
    @black = Array.new(n,nil)
  end

  def solve
    (white(0) + black(0)) % MOD
  end

  def white(v)
    return @white[v] if @white[v]
    return 1 if g[v].empty?
    ans = 1
    g[v].each do |nv|
      cnt = (white(nv) + black(nv)) % MOD
      ans = (ans * cnt) % MOD
    end
    @white[v] = ans
  end

  def black(v)
    return @black[v] if @black[v]
    return 1 if g[v].empty?
    ans = 1
    g[v].each do |nv|
      cnt = white(nv)
      ans = (ans * cnt) % MOD
    end
    @black[v] = ans
  end

  def show(ans)
    puts ans
  end
end

Problem.new.instance_eval do
  show(solve)
end

