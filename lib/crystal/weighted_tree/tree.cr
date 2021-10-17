module WeightedTree
  class Tree
    getter n : Int32
    getter g : Array(Array(Tuple(Int32, Int64)))
    delegate "[]", to: g

    def initialize(n)
      @n = n.to_i
      @g = Array.new(n) { [] of Tuple(Int32, Int64) }
    end

    def add(v, nv, cost, origin = 1, both = true)
      v = v.to_i - origin
      nv = nv.to_i - origin
      cost = cost.to_i64

      g[v] << {nv, cost}
      g[nv] << {v, cost} if both
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
          g[v].each do |nv, cost|
            next if v >= nv
            fh.puts "  #{v + origin} -- #{nv + origin} [label = #{cost}];"
          end
        end
        fh.puts "}"
      end
      puts `cat debug.dot | graph-easy --from=dot --as_ascii`
    end
  end
end
