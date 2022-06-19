require "crystal/abstract_graph/graph"

module AbstractGraph
  # トポロジカルソート
  # ループ検出
  # 最長路を求める
  class Tsort(V)
    getter g : Graph(V)
    getter ind : Hash(V, Int64) # 入次数

    def initialize(@g)
      # 入次数を求める
      @ind = {} of V => Int64

      g.keys.each do |v|
        ind[v] = 0_i64
      end

      g.keys.each do |v|
        g[v].each do |nv|
          ind[nv] += 1
        end
      end
    end

    # トポロジカルソート
    # 破壊的にindを更新
    # 依存順に並べる（親->子）
    def solve
      ans = [] of V
      q = Deque(V).new

      ind.each do |v, count|
        q << v if count.zero?
      end

      while q.size > 0
        v = q.shift
        ans << v

        g[v].each do |nv|
          ind[nv] -= 1
          q << nv if ind[nv].zero?
        end
      end
      ans
    end

    # ループの有無
    # ループがあるならnil
    # ないなら、トポロジカルソートの結果を返す
    def has_loop?
      solve.tap do |path|
        return nil if path.size < g.keys.size
      end
    end

    # 最長路を求める
    # 各頂点への最長パスの長さを{} of V => Int64で返す
    # グラフ全体の最長パスを求めるには、values.max
    def longest_path
      # ループがあるならnilでreturn
      has_loop?.try do |path|
        # 親から順にdp、最短路はあとから最長路で上書きされる
        dp = {} of V => Int64
        path.each { |v| dp[v] = 0_i64 }

        path.each do |v|
          g[v].each do |nv|
            dp[nv] = dp[v] + 1
          end
        end
        dp
      end
    end
  end
end

alias Tsort = AbstractGraph::Tsort
