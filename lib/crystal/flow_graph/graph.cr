# フロー用グラフ（逆辺、容量あり）
module FlowGraph
  alias V = Int32
  alias RV = Int32
  alias Cap = Int64
  alias E = Tuple(V, RV, Cap)

  class Graph
    getter n : Int32
    getter g : Array(Array(E))
    delegate "[]", to: g

    def initialize(n)
      @n = n.to_i
      @g = Array.new(n) { [] of E }
    end

    def add(v, nv, cap, origin = 0)
      v = V.new(v) - origin
      nv = V.new(nv) - origin
      cap = Cap.new(cap)

      rev_v = g[v].size
      rev_nv = g[nv].size

      g[v] << E.new nv, rev_nv, cap
      g[nv] << E.new v, rev_v, Cap.zero
    end

    @[AlwaysInline]
    def add_cap(e : E, cost : Cap)
      nv, rev, cap = e
      E.new(nv, rev, cap + cost)
    end

    def debug
      File.open("debug.dot", "w") do |fh|
        fh.puts "graph tree {"
        n.times do |v|
          g[v].each do |(nv,rv,cap)|
            # next if v >= nv
            next if cap == 0
            fh.puts "  #{v} -> #{nv};"
          end
        end
        fh.puts "}"
      end
      puts `cat debug.dot | graph-easy --from=dot --as_ascii`
    end
  end
end
