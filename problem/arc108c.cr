alias Pair = Tuple(Int32,Int32)

class Graph
  getter n : Int32
  getter m : Int32
  getter g : Array(Array(Pair))

  def self.read
    n,m = gets.to_s.split.map { |v| v.to_i }
    g = Array.new(n){ [] of Pair }
    m.times do
      u,v,c = gets.to_s.split.map { |v| v.to_i }
      u -= 1
      v -= 1
      g[u] << Pair.new(v,c)
      g[v] << Pair.new(u,c)
    end
    new(n,m,g)
  end

  def initialize(@n,@m,@g)
  end

  def spanning_tree
    tree = Tree.new(n)
    seen = [true] + [false] * (n-1)
    q = Deque(Int32).new([0])

    while q.size > 0
      v = q.shift
      g[v].each do |edge|
        nv,c = edge
        next if seen[nv]
        seen[nv] = true
        q << nv
        tree[v] << edge
      end
    end
    return tree
  end
end

class Tree
  getter n : Int32
  getter g : Array(Array(Pair))
  forward_missing_to g

  def initialize(@n)
    @g = Array.new(n){ [] of Pair }
  end

  def debug(lv = 0, v = 0, c = -1, pv = -1)
    printf("%s %d[%d]\n", " " * lv, v+1, c)
    g[v].each do |nv, nc|
      next if nv == pv
      debug(lv + 2, nv, nc, v)
    end
  end

  def solve
    ans = Array.new(n, -1)
    dfs(0, -1, -1, ans)
    ans
  end

  def color(v, c, pv, pc)
    # 親の有無、親パスの有無、子パスの有無
    # 親が無い
    #   親パスが無い
    # 　　子が無い 1
    # 　　子パスがあるなら、子パスの色のどれかを設定
    #   親パスがある　ありえない
    # 親がある
    # 　親パスがある
    # 　　親の色と、親パスの色が違うなら、親パスの色
    # 　　親の色と、親パスの色が同じなら
    # 　　　子が無い
    # 　　　　親パスの色の次
    # 　　　子がある
    # 　　　　（子パス - 親パス）が空
    # 　　　　　　親パスの色の次
    # 　　　　　空でない
    # 　　　　　　それの最初
    # 　親パスが無い　ありえない
    raise "error #{pv} #{c}" if (pv == -1 ^ c != -1)
    if pv == -1
      if g[v].empty?
        1
      else
        g[v][0][1]
      end
    else
      if c != pc 
        c
      else
        if g[v].empty?
          (c % n) + 1
        else
          cs = (g[v].map(&.last) - [pc])
          if cs.empty?
            (pc % n) + 1
          else
            cs.first
          end
        end
      end
    end
  end

  def dfs(v, c, pv, ans)
    ans[v] = color(v, c, pv, ans[pv])
    g[v].each do |nv,nc|
      dfs(nv, nc, v, ans)
    end
  end
end

g = Graph.read
n = g.n
ans = Array.new(n, -1)
tree = g.spanning_tree
# pp! tree
# tree.debug
tree.solve.each do |i|
  puts i
end

