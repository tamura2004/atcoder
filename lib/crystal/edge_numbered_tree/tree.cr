module EdgeNumberedTree
  class Tree
    getter n : Int32
    getter id : Int32
    getter g : Array(Array(Tuple(Int32, Int32)))
    getter both : Bool
    delegate "[]", to: g

    def initialize(n, @both = true)
      @n = n.to_i
      @id = 0
      @g = Array.new(n) { [] of Tuple(Int32, Int32) }
    end

    def add(v, nv, origin = 1)
      v = v.to_i - origin
      nv = nv.to_i - origin
      g[v] << {nv, id}
      g[nv] << {v, id} if both
      @id += 1
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
            fh.puts "  #{v + origin} -- #{nv + origin} [label = #{ix}];"
          end
        end
        fh.puts "}"
      end
      puts `cat debug.dot | graph-easy --from=dot --as_ascii`
    end
  end
end
