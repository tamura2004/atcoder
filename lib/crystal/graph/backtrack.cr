require "crystal/graph/i_graph"
require "crystal/graph/in_deg"

# 後退解析によりゲーム木のノードごとの勝敗・引き分けを求める
# 
# Example:
# ```
# # 3 -> 3, 1 -> 2の場合
# g = Graph.new(3)
# g.add 3, 3, both: false
# g.add 2, 1, both: false # 逆順
# Backtrack.new(g).solve.should eq [
#   Backtrack::Game::Win,
#   Backtrack::Game::Lose,
#   Backtrack::Game::Draw
# ]
# ```
class Backtrack
  enum Game
    Win
    Lose
    Draw
end

  getter g : IGraph
  delegate n, to: g

  def initialize(@g)
    # 遷移先 -> 遷移元のDAG（直感とは逆）
  end

  def solve
    ans = Array.new(n, Game::Draw) # 勝敗・引き分け
    seen = Array.new(n, false) # 決定済
    q = Deque.new([] of Int32) # キュー
    deg = InDeg.new(g).solve # 入次数

    # 入次数が0のノードは末端なので遷移先がなく負け
    n.times do |v|
      if deg[v].zero?
        ans[v] = Game::Lose
        q << v
        seen[v] = true
      end
    end

    while q.size > 0
      v = q.shift
      g.each(v) do |nv|
        next if seen[nv]

        deg[nv] -= 1
        if ans[v] == Game::Lose
          # 一手先に負けを選べるなら勝ち
          ans[nv] = Game::Win
          q << nv
          seen[nv] = true
        elsif deg[nv] == 0
          # 全ての遷移先が勝ちなら負け
          # 入次数が0になるまでif節を満たさなかったので
          ans[nv] = Game::Lose
          q << nv
          seen[nv] = true
        end
      end
    end

    ans
  end
end
