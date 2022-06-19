# 閉路を求める問題
# 例えば以下のように
# 1 -> 2 -> 3
# ^    |    |
# |    v    v
# 4 <- 5 <- 6
# 複数の閉路がくっついている場合、外側はダメ
# 小さいほうの閉路なら良い
#
# サイズが２以上の強連結成分は必ず題意のループを含む？
# いや、全体が強連結の場合など、問題すすまなさそう
#
# 最小閉路だから、BFSしてみる？
# n <= 1000だから、頂点は全探索できそう
# BFSして最初の後退辺があったら出力
#
# いや、パスを持てないので出力できなさそう
# 
# 頂点とパス長さの最小を求めてから
#
# 力技でBFSにパス持たせる？
# 2 ^ 500とか行きそう、無理
#
# 始点を決めてBFSするごとに、親の頂点を記録していく
# 自身に到達したら、仮出力
# 長さで更新
# いってみよー

require "crystal/graph"

struct ShortestLoop
  getter g : Graph
  delegate n, to: g

  def initialize(@g)
  end

  def solve(root)
    pa = Array.new(n, -1)
    seen = Array.new(n, false)
    seen[root] = true
    q = Deque.new([root])

    while q.size > 0
      v = q.shift

      g[v].each do |nv|
        if nv == root
          # pp! [root,v,nv]
          ans = [] of Int32
          while v != -1
            ans << v
            v = pa[v]
          end
          return ans
        end

        next if seen[nv]
        seen[nv] = true
        pa[nv] = v
        q << nv
      end
    end

    return nil
  end
end



n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv, both: false
end

# g.debug(di: false)
ans = [] of Int32

n.times do |root|
  if path = ShortestLoop.new(g).solve(root)
    ans = path if ans.empty? || ans.size > path.size
  end
end

quit -1 if ans.empty?

# pp ans

puts ans.size
quit ans.map(&.succ).sort.join("\n")
