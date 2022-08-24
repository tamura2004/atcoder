class BFS(V)
  getter n : Int32
  getter delta : Proc(V, Proc(V,Nil), Nil)
  getter index : Proc(V, Int32)

  def initialize(@n, @delta, @index)
  end

  def solve(root : V)
    dist = Array.new(n, -1)
    q = Deque.new([root])
    dist[index.call(root)] = 0_i64

    while q.size > 0
      v = q.pop
      delta.call(v, -> (nv : V) {
        next if dist[index[nv]] != -1
        dist[index(nv)] = dist[index(v)] + 1
        q << nv
      })
    end
    dist
  end
end
