# bitDP + 後退解析
# dp[s選んだ単語の集合][i最後に選ばれた単語] := この状態で手番を開始したときの勝ち負け
# 遷移先に一つでも「負け」があれば「勝ち」
# 遷移先が全て「勝ち」なら「負け」
# 初期状態は「負け」
# 遷移先が「負け」なら、遷移元をすべて「勝ち」にする
# 遷移先が「勝ち」なら、何もしない

require "crystal/graph/backtrack"

n = gets.to_s.to_i
a = Array.new(n) { gets.to_s }
puts got(n, a)

enum Game
  Win
  Lose
end

def want(n, a)
  dp = make_array(Game::Lose, 1<<n, n)

  (0...1<<n).reverse_each do |s|
    n.times do |v|
      next if s.bit(v) == 0
      n.times do |nv|
        next if v == nv
        next if s.bit(nv) == 0
        next if a[v][-1] != a[nv][0]
        next if dp[s][nv].win?
        
        # 遷移、{t,v} -> {s,nv}
        # v.in?(t) && nv.in?(s) && v != nv
        # t = s - {nv}
        
        t = s ^ (1 << nv)
        dp[t][v] = Game::Win
      end
    end
  end

  n.times do |v|
    s = (1<<v)
    return :First if dp[s][v].lose?
  end
  return :Second
end

def got(n, s)
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
  # 最初に単語を選ぶ状態を頂点として追加
  n.times do |i|
    v = {1<<i, i}
    gg.add_vertex(v)
  end
  (1 << n).times do |s|
    n.times do |v|
      next unless s.bit(v) == 1
      g.each(v) do |nv|
        next unless s.bit(nv) == 0
        gg.add ({s, v}),({s | (1 << nv), nv}), both: false
      end
    end
  end

  cnt = Backtrack.new(gg).solve

  # 1手選ばれた状態を検索（後攻の開始手番）
  ans = n.times do |i|
    v = {1 << i, i}
    next unless gg.ix.has_key?(v)
    # 後攻が負けの状態を先行が選べるなら
    return :First if cnt[gg.ix[v]].lose?
  end
  # すべての選べる状態が後攻の勝ち
  return :Second
end