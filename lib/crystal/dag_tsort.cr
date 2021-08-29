# 有向グラフのトポロジカルソート
#
# ```
# g = Graph.new(4)
# g.add 3, 1
# g.add 1, 2
# g.add 1, 4
# g.tsort #=> [3, 1, 2, 4]
# ```
class Graph
  getter n : Int32
  getter g : Array(Array(Int32))
  getter h : Array(Int32) # 入次数

  def initialize(n)
    @n = n.to_i
    @g = Array.new(n){ [] of Int32 }
    @h = Array.new(n, 0)
  end

  def add(v,nv,origin=1,both=false)
    v = v.to_i - origin
    nv = nv.to_i - origin
    
    g[v] << nv
    h[nv] += 1
    g[nv] << v if both
    h[v] += 1 if both
  end

  # トポロジカルソート
  def tsort
    ans = [] of Int32
    q = Deque(Int32).new
    h.each_with_index { |v,i| q << i if v.zero? }

    while q.size > 0
      v = q.shift
      ans << v

      g[v].each do |nv|
        h[nv] -= 1
        q << nv if h[nv].zero?
      end
    end

    ans
  end

  # ループの有無
  def have_loop?
    tsort.size < n
  end
end
