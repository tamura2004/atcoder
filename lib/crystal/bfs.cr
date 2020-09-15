# 隣接リストグラフgを持つことを利用する
# @pre : Bool 訪問済チェック前にブロックを実行
module BFS
  def bfs(init, pre = false)
    seen = Array.new(g.size, false)
    seen[init] = true
    que = [init]
    while que.size > 0
      v = que.shift
      g[v].each do |nv|
        yield v,nv if pre
        next if seen[nv]
        yield v,nv unless pre
        seen[nv] = true
        que << nv
      end
    end
    seen
  end
end
