# 回答に辺の情報が必要な場合のグラフ
#
# edgesに登録順の辺の情報を保持
module EdgeLabeledGraph
  class Graph
    getter g : Array(Array(Tuple(Int32, Int32)))
    getter edges : Array(Tuple(Int32, Int32))
    getter n : Int32
    delegate "[]", to: g

    def initialize(@n)
      @g = Array.new(n) { [] of Tuple(Int32, Int32) }
      @edges = [] of Tuple(Int32, Int32)
    end

    # 辺の追加順を記録
    def add(v, nv, origin = 1, both = true)
      v = v.to_i - origin
      nv = nv.to_i - origin
      ix = edges.size

      g[v] << {nv, ix}
      g[nv] << {v, ix} if both

      edges << {v + origin, nv + origin}
    end

    # デバッグ用：アスキーアートで可視化
    def debug(origin = 1)
      case n
      when 0
        puts "++"
        puts "++"
        return
      when 1
        puts "+---+"
        puts "| #{origin} |"
        puts "+---+"
        return
      end

      File.open("debug.dot", "w") do |fh|
        fh.puts "digraph tree {"
        n.times do |v|
          g[v].each do |nv, ix|
            next if v >= nv
            fh.puts "  #{v + origin} -- #{nv + origin} [label = #{ix + origin}];"
          end
        end
        fh.puts "}"
      end
      puts `cat debug.dot | graph-easy --from=dot --as_ascii`
    end
  end
end
