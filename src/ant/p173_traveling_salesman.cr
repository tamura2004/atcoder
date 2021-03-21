require "crystal/matrix_graph"
require "crystal/bit_set"

# 巡回セールスマン問題
#
# 頂点数*n*の重み付き有向グラフが与えられる。
# 頂点0から開始して全ての頂点を丁度1回づつ通って0に
# 戻ってくる閉路の最小のコストを求めよ。
#
# ```
# # [5] --6--> [2]
# #  ^ \      3 |
# #  |  7    /  5
# #  3   [1]    |
# #  |  /   4   |
# #  | 4      \ V
# # [4] <--5-- [3]
#
# g = TSP.new(5)
# g.add_edge_1_indexed 1, 2, 3
# g.add_edge_1_indexed 1, 4, 4
# g.add_edge_1_indexed 2, 3, 5
# g.add_edge_1_indexed 3, 1, 4
# g.add_edge_1_indexed 3, 4, 5
# g.add_edge_1_indexed 4, 5, 3
# g.add_edge_1_indexed 5, 1, 7
# g.add_edge_1_indexed 5, 2, 6
# pp g.solve(0) # => 22 [1-4-5-2-3-1]
# ```
class TSP < MatrixGraph

  # ビットDPで開始地点*init*からの巡回路の長さを求める
  #
  # dp[訪問済頂点S][最後の点i] := 経路の長さ
  # dp[0][0] = 0 | other INF
  # dp[S|j][j] = min dp[S][i] + cost(i->j)
  def solve(init)
    dp = Array.new(1<<n) { Array.new(n, INF) }

    # initからの距離で初期化、initを未訪問にすることにより
    # 戻ってくる経路も答えに含まれる
    n.times do |i|
      next if i == init
      dp[1<<i][i] = g[init][i]
    end

    # 訪問済集合Sをトポロジカルソート順に列挙
    (1<<n).times do |s|
      # Sの要素を列挙
      s.bits.each do |i|
        # S以外の要素を列挙
        s.inv(n).bits.each do |j|
          next if g[i][j] == INF
          next if dp[s][i] == INF
          chmin dp[s.on(j)][j], dp[s][i] + g[i][j]
        end
      end
    end
    return dp[-1][0]
  end
end
