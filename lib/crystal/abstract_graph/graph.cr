# 任意のオブジェクトを頂点としたグラフ
# ただし`Hash`のキーになる必要がある
# `#hash`,`#==`を実装
module AbstractGraph
  class Graph(V)
    getter g : Hash(V, Array(V))
    delegate keys, "[]", to: g

    def initialize
      @g = {} of V => Array(V)
    end

    # 頂点の追加
    # 頂点の列挙を`#keys`で行う都合上
    # 明示的に頂点追加を行わないと、入次数0の頂点が漏れる
    def add_vertex(v)
      v.tap do |v|
        g[v] = [] of V if !g.has_key?(v)
      end
    end

    # 辺の追加
    # 頂点の正規化、空の隣接リストの追加を行う
    def add(v, nv, both = false)
      v = add_vertex(v)
      nv = add_vertex(nv)
      g[v] << nv
      g[nv] << v if both
    end

    def to_s(io)
      File.open("debug.dot", "w") do |fh|
        fh.puts "graph tree {"
        keys.each do |v|
          g[v].each do |nv|
            fh.puts " \"#{v}\" -> \"#{nv}\";"
          end
        end
        fh.puts "}"
      end
      io << `cat debug.dot | graph-easy --from=dot --as_ascii`
    end
  end
end

alias Graph = AbstractGraph::Graph