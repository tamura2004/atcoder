require "crystal/graph"

# 木（重みなし）
class Tree < Graph
  # 親リストから読み込む
  def read_plist(a)
    a.each_with_index do |v, i|
      add v, i + 1, both: true
    end
  end

  # 0をDAGにする
  def tsort!
    h = Array.new(n) { [] of Int32 }
    seen = Array.new(n, false)
    seen[0] = true
    q = Deque.new([0])
    while q.size > 0
      v = q.shift
      g[v].each do |nv|
        next if seen[nv]
        seen[nv] = true
        h[v] << nv
        q << nv
      end
    end
    @g = h
  end

  def dfs(v, pv = -1)
    g[v].each do |nv|
      yield v, nv
    end
  end


  # スタックを利用したDFS
  def dfs(init = 0)
    q = Deque.new([~init, init])
    while q.size > 0
      v = q.pop
      if v < 0
        g[~v].each_with_index do |nv, i|
          yield ~v, nv, i,1
        end
      else
        g[v].each_with_index do |nv,i|
          yield v,nv,i,0
          q << ~nv
          q << nv
        end
      end
    end
  end

  # キューを利用したBFS
  def bfs(init = 0)
    q = Deque.new([init])
    while q.size > 0
      v = q.shift
      g[v].each_with_index do |nv, i|
        yield v, nv, i
        q << nv
      end
    end
  end
end
