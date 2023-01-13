require "crystal/graph"
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
#   Backtrack::Game::Draw,
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
    seen = Array.new(n, false)     # 決定済
    q = Deque.new([] of Int32)     # キュー
    deg = InDeg.new(g).solve       # 入次数

    # 入次数が0のノードは末端なので遷移先がなく勝ち
    n.times do |v|
      if deg[v].zero?
        ans[v] = Game::Win
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

n = gets.to_s.to_i
s = Array.new(n) { gets.to_s }

# 単語のつながりのグラフを作る
g = Graph.new(n)
n.times do |v|
  n.times do |nv|
    next if v == nv
    next unless s[v][-1] == s[nv][0]
    g.add v, nv, both: false, origin: 0
  end
end

# 選んだ単語の集合S, 最後の単語vとしてグラフを作る
gg = BaseGraph(Tuple(Int32, Int32)).new
(1 << n).times do |s|
  n.times do |v|
    next unless s.bit(v) == 1
    g.each(v) do |nv|
      next unless s.bit(nv) == 0
      gg.add ({s | (1 << nv), nv}), ({s, v}), both: false
    end
  end
end

cnt = Backtrack.new(gg).solve

ans = n.times do |i|
  v = {1 << i, i}
  next unless gg.ix.has_key?(v)
  quit :First if cnt[gg.ix[v]].win?
end
puts :Second
