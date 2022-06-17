# タプル＝ペアを頂点としたグラフ
class Graph
  alias V = Tuple(Int32, Int32) # 頂点の型
  getter g : Hash(V, Array(V))  # 隣接リスト
  getter ind : Hash(V, Int32)   # 入次数

  def initialize(vs)
    @g = Hash(V, Array(V)).new
    @ind = Hash(V, Int32).new

    vs.each do |v|
      g[v] = [] of V
      ind[v] = 0
    end
  end

  # 辺を追加
  def add(v, nv)
    v = f(v)
    nv = f(nv)
    g[v] << nv
    ind[nv] += 1
  end

  # トポロジカルソート
  def tsort
    ans = [] of V
    q = Deque(V).new

    ind.each do |k, v|
      q << k if v.zero?
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
  def has_loop?
    tsort.size < g.keys.size
  end

  # 最長パス
  def longest_path
    path = tsort
    return nil if path.size < g.keys.size # ループがあるなら∞

    dp = Hash(V, Int32).new
    path.each { |v| dp[v] = 0 }

    path.each do |v|
      g[v].each do |nv|
        dp[nv] = dp[v] + 1
      end
    end

    dp
  end

  # {1,2}と{2,1}を同じ頂点とみなす
  def f(v)
    return v if v[0] < v[1]
    {v[1], v[0]}
  end
end

# タプルを頂点としたグラフ
# ループの検出
# 最長路の取得
# 方針：トポロジソートしてＤＰ

n = gets.to_s.to_i
vs = [] of Tuple(Int32, Int32)

(1..n).to_a.each_combination(2) do |v|
  vs << Tuple(Int32, Int32).from(v)
end

g = Graph.new(vs)

(1..n).each do |i|
  vs = gets.to_s.split.map(&.to_i)
  vs.each_cons_pair do |j, k|
    g.add ({i, j}), ({i, k})
  end
end

if ans = g.longest_path
  pp ans.values.max + 1
else
  pp -1
end
