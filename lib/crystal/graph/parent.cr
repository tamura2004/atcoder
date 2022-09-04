require "crystal/graph/i_graph"

# 根付き木について、2^k先の親の頂点と深さを求める
# また、それを利用して、根方向へk移動した点を求める
#
# ```
# g = Graph.new([-1,0,1,2,3,4,5,6])
# pa = Parent.new(g, root: 7)
# pa.up(0,5).should eq 5
# ```
class Parent
  D = 40

  getter g : IGraph
  delegate n, to: g
  getter root : Int32
  getter pa : Array(Array(Int32))
  delegate "[]", to: pa
  
  # ダブリング用に2^k先の親の頂点を求める
  def initialize(@g, @root = 0)
    g.tree!
    @pa = Array.new(D) { Array.new(n, -1) }

    # 親の頂点を求める
    q = Deque.new([{root,-1}])
    while q.size > 0
      v, pv = q.shift
      pa[0][v] = pv
      g.each(v) do |nv|
        next if nv == pv
        q << {nv,v}
      end
    end

    (1...D).each do |k|
      g.each do |v|
        next if pa[k-1][v] == -1
        pa[k][v] = pa[k-1][pa[k-1][v]]
      end
    end
  end

  def solve
    pa[0]
  end

  # ダブリングで頂点vから根方向へk移動した点を返す
  def up(v, k)
    D.times do |i|
      if k.bit(i) == 1
        v = pa[i][v]
      end
      break if v == -1
    end
    v
  end
end