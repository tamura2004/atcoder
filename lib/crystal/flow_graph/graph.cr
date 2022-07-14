module FlowGraph
  enum Dir
    Forward # 正辺
    Reverse # 逆辺
  end

  # 容量Tと逆辺の番号を持つ辺
  class Edge
    getter v : Int32
    getter re : Int32 # 逆辺の番号
    property cap : Int64
    getter dir : Dir

    def initialize(@v, @re, @cap, @dir)
    end
  end

  # フロー用グラフ（容量、逆辺あり）
  class Graph
    getter n : Int32
    getter g : Array(Array(Edge))

    delegate "[]", to: g

    def initialize(n)
      @n = n.to_i
      @g = Array.new(n) { [] of Edge }
    end

    # 辺と逆辺を追加する
    def add(v, nv, cap, origin = 0)
      v = v.to_i - origin
      nv = nv.to_i - origin
      cap = cap.to_i64

      i = g[v].size  # これから追加する辺はi番目
      j = g[nv].size # これから追加する逆辺はj番目

      g[v] << Edge.new(nv, j, cap, Dir::Forward)
      g[nv] << Edge.new(v, i, 0_i64, Dir::Reverse)

      return i
    end

    # デバッグ用（AA表示）
    def debug(origin = 0)
      File.open("debug.dot", "w") do |fh|
        fh.puts "digraph tree {"
        n.times do |v|
          g[v].each do |e|
            nv, re, cap, dir = e.v, e.re, e.cap, e.dir
            next if dir.reverse?
            r_cap = g[nv][re].cap
            fh.puts "  #{v + origin} -> #{nv + origin} [label=\"#{f cap}[#{f r_cap}]\"]"
          end
        end
        fh.puts "}"
      end
      puts `cat debug.dot | graph-easy --from=dot --as_ascii`
    end

    def f(v)
      v == Int64::MAX ? "INF" : v.to_s
    end
  end
end

alias Graph = FlowGraph::Graph