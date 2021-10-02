module Abc204
  module E
    class Graph
      getter n : Int32
      getter g : Array(Array(Tuple(Int32, Int64, Int64)))
      delegate "[]", to: g

      def initialize(n)
        @n = n.to_i
        @g = Array.new(n) { [] of Tuple(Int32, Int64, Int64) }
      end

      def add(v, nv, c, d, origin = 1, both = true)
        c = c.to_i64
        d = d.to_i64
        v = v.to_i - origin
        nv = nv.to_i - origin
        g[v] << {nv, c, d}
        g[nv] << {v, c, d} if both
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
            g[v].each do |nv, c, d|
              next if v >= nv
              fh.puts "  #{v + origin} -- #{nv + origin} [label = \"#{c},#{d}\"];"
            end
          end
          fh.puts "}"
        end
        puts `cat debug.dot | graph-easy --from=dot --as_ascii`
      end
    end
  end
end
