# 任意のオブジェクトを頂点としたグラフ
# ただし`Hash`のキーになる必要がある
# `#hash`,`#==`を実装
module AbstractGraph
  class Graph(V, E)
    getter g : Hash(V, Array(E))
    delegate keys, "[]", to: g

    def initialize
      @g = Hash(V,Array(E)).new do |h, k|
        h[k] = [] of E
      end
    end

    # 辺の追加
    # 頂点の正規化、空の隣接リストの追加を行う
    def add(v, e)
      g[v] << e
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