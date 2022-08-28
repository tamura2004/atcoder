# 重みなしグラフのデバッグ出力用
module Printable
  abstract def each(&b : Int32 -> _)
  abstract def each(v : Int32, &b : Int32 -> _)
  abstract def both : Bool
  abstract def origin : Int32

  def to_s(io)
    graph_type = both ? "digraph" : "graph"

    File.open("debug.dot", "w") do |fh|
      fh.puts "#{graph_type} g {"
      each do |v|
        each(v) do |nv|
          next if both && v > nv
          fh.puts "\"#{v}\" -> \"#{nv}\";"
        end
      end
      fh.puts "}"
    end
    io << `cat debug.dot | graph-easy --from=dot --as_ascii`
  end

  def inspect(io)
    to_s(io)
  end
end
