require "crystal/graph/i_graph"

# ρ法で問題を解く
#
# 状態遷移が出次数が全て1のDAGとみなせる場合
# 大きな状態遷移回数kに対して、O(N)で以下を求める
# goal : 最終位置
# path : ループ開始までの経路
# m : path上のループ開始位置
# hist : path上の訪問回数
#
# ```
# # [0] -> [1] -> [2] -> [3] -> [4]
# #                ^             |
# #                +-------------+
# g = Graph.new(5)
# g.add 0, 1, both: false, origin: 0
# g.add 1, 2, both: false, origin: 0
# g.add 2, 3, both: false, origin: 0
# g.add 3, 4, both: false, origin: 0
# g.add 4, 2, both: false, origin: 0

# ro = Ro.new(g).solve(9)
# ro.goal # => 3
# ro.n # => 5
# ro.m # => 2
# ro.path # => [0, 1, 2, 3, 4]
# ro.hist # => [1, 1, 3, 3, 2] # ループしない場合は hist.size <= path.size
# ```
class Ro
  getter g : IGraph

  getter path : Array(Int32) # 移動経路
  getter seen : Array(Int32) # 最初に通過した順番
  getter n : Int32           # 経路の長さ
  getter m : Int32           # ループの開始点
  getter goal : Int32        # 移動終了時のノード
  getter hist : Array(Int64) # 各ノードの訪問頻度

  def initialize(@g)
    raise "出次数が1以外のノードがあります #{@g.inspect}" if @g.g.any?(&.size.!= 1)
    @path = [] of Int32
    @seen = Array.new(g.n, -1)
    @n = -1
    @m = -1
    @goal = -1
    @hist = [] of Int64
  end

  # rootからk回進んだ時の状態（k=0,進まない）
  def solve(k, root = 0)
    k = k.to_i64
    root = root.to_i

    dfs(root, 0)

    if k < n # ループしない場合
      @goal = path[k]
    else
      @goal = path[m + (k - n) % (n - m)]
    end

    # 訪問回数
    path.each_with_index do |v, i|
      next unless i <= k
      if i < m
        hist << 1_i64
      else
        hist << (k - m + n - i) // (n - m)
      end
    end

    # 必要な情報はインスタンス変数から取得
    self
  end

  def dfs(v, i)
    # 訪問済ならループ開始点
    if seen[v] != -1
      @n = path.size
      @m = seen[v]
      return
    end

    # 訪問順と経路に追加
    seen[v] = i
    path << v

    g.each(v) do |nv|
      dfs(nv, i + 1)
    end
  end
end
