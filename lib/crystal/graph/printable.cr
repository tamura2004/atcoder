# 重みなしグラフのデバッグ出力用
module Printable
  abstract def each(&b : Int32 -> _)
  abstract def each : Iterator(Int32) #(&b : Int32 -> _)
  abstract def each(i : Int32, &b : Int32 -> _)
  abstract def origin : Int32
  abstract def both : Bool

  def to_s(io)
    graph_type = both ? "digraph" : "graph"
    arrow = both ? "--" : "->"
    weighted = weighted?

    File.open("debug.dot", "w") do |fh|
      fh.puts "#{graph_type} g {"
      each do |v|
        each_with_cost(v) do |nv, cost|
          next if both && v > nv
          if weighted
            fh.puts "\"#{v + origin}\" #{arrow} \"#{nv + origin}\" [label = \"#{cost}\"];"
          else
            fh.puts "\"#{v + origin}\" #{arrow} \"#{nv + origin}\";"
          end
        end
      end
      fh.puts "}"
    end
    io << `cat debug.dot | graph-easy --from=dot --as_ascii`
  end

  def inspect(io)
    to_s(io)
  end

  # s式の文字列に変換
  def to_sexp(root = 0)
    dfs_sexp(root, -1)
  end

  def dfs_sexp(v, pv)
    # pp! [v,pv]
    ret = [v.to_s]
    each(v) do |nv|
      next if nv == pv
      ret << dfs_sexp(nv, v)
    end
    
    if ret.size > 1
      ret[0] = "(" + ret[0]
      ret[-1] += ")"
    end
    ret.join(" ")
  end
end
