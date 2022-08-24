class BFS(V)
  getter n : Int32
  getter delta : Proc(V, Proc(V, Nil), Nil)
  getter ix : Proc(V, Int32)

  def initialize(@n, @delta, @ix)
  end

  def solve(root : V)
    dist = Array.new(n, -1)
    q = Deque.new([root])
    dist[ix.call(root)] = 0_i64

    while q.size > 0
      v = q.pop
      delta.call(v, ->(nv : V) {
        if dist[ix.call(nv)] == -1
          dist[ix.call(nv)] = dist[ix.call(v)] + 1
          q << nv
          nil
        end
      })
    end
    dist
  end
end

n = 4
g = Array.new(4) { [] of Int32 }
g[0] << 1
g[1] << 0
g[1] << 2
g[2] << 1
g[1] << 3
g[3] << 1

delta = ->(v : Int32, f : Proc(Int32, Nil)) {
  g[v].each { |nv| f.call(nv) }
}

index = -> (v : Int32) { v }

bfs = BFS(Int32).new(4, delta, index)
pp bfs.solve(0)
