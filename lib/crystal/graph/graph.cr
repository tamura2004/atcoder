# 重みなしグラフ
alias V = Int32

class Graph
  getter n : Int32
  getter g : Array(Array(Int32))
  delegate "[]", to: g

  def initialize(@n, @g)
  end

  def initialize(n)
    @n = n.to_i
    @g = Array.new(n) { [] of Int32 }
  end

  def initialize(n, m)
    initialize(n)
    m.times do |i|
      yield self, i
    end
  end

  # vからnvに辺を追加する
  #
  # origin : 0-indexed or 1-indexed
  # both : 無向グラフ、有向グラフ
  def add(v, nv, origin = 1, both = true)
    v = v.to_i - origin
    nv = nv.to_i - origin
    g[v] << nv
    g[nv] << v if both
  end

  def bfs(root = 0)
    seen = Array.new(n, false)
    seen[root] = true
    q = Deque.new([root])
    while q.size > 0
      v = q.shift
      g[v].each do |nv|
        next if seen[nv]
        seen[nv] = true
        yield v, nv
        q << nv
      end
    end
  end

  # 連結成分に分解
  #
  # ```
  # g = Graph.new(4)
  # g.add 1, 2
  # g.add 3, 4
  # g.decomposit_connected_element # => {[0,1,0,1],[[0,1],[2,3]]
  # ```
  def decomposit_connected_element
    seen = Array.new(n, false)

    ix = [-1] * n
    conn = [] of Array(Int32)

    n.times do |iv|
      next if seen[iv]
      seen[iv] = true

      ix[iv] = 0
      con = [iv]
      q = Deque.new([iv])

      while q.size > 0
        v = q.shift
        g[v].each do |nv|
          next if seen[nv]
          seen[nv] = true

          ix[nv] = con.size
          con << nv
          q << nv
        end
      end
      conn << con
    end
    return {ix, conn}
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
      fh.puts "graph tree {"
      n.times do |v|
        g[v].each do |nv|
          # next if v >= nv
          fh.puts "  #{v + origin} -> #{nv + origin};"
        end
      end
      fh.puts "}"
    end
    puts `cat debug.dot | graph-easy --from=dot --as_ascii`
  end
end
