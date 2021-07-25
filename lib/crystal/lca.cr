require "crystal/tree"

# 最小共通祖先
#
# ```
# g = Tree.new(5)
# g.add 1,2
# g.add 2,3
# g.add 2,4
# g.add 1,5
#
# lca = LCA.new(g)
# pp lca.query(2, 5, origin = 1) #=> 1
# pp lca.query(3, 4, origin = 1) #=> 2
# ```
class LCA
  getter n : Int32
  getter g : Tree
  getter len : Array(Int32) # rootからの距離
  getter par : Array(Array(Int32)) # par[k][v] := vの2^k先の親

  delegate add, to: g

  def initialize(@g)
    @n = g.n

    k = 1
    while (1 << k) < n
      k += 1
    end

    @len = [-1] * n
    @par = (0..k).map { [-1] * n }
    
    q = Deque.new([0])
    len[0] = 0
    while q.size > 0
      v = q.shift
      g[v].each do |nv|
        next if len[nv] != -1
        len[nv] = len[v] + 1
        par[0][nv] = v
        q << nv
      end
    end

    (0...k).each do |i|
      n.times do |v|
        if par[i][v] > 0
          pv = par[i][v]
          par[i+1][v] = par[i][pv]
        end
      end
    end
  end

  def query(u, v, origin = 0)
    u = u.to_i - origin
    v = v.to_i - origin

    u, v = v, u if len[u] < len[v]

    par.size.times do |i|
      if (len[u] - len[v]).bit(i) == 1
        u = par[i][u]
      end
    end

    return u if u == v

    (par.size - 1).downto(0) do |i|
      if par[i][u] != par[i][v]
        u = par[i][u]
        v = par[i][v]
      end
    end

    return par[0][u] + origin
  end
end
