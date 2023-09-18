require "crystal/graph/i_graph"
require "crystal/cc"

# 二部グラフの最大マッチングを求める
#
# Example:
# ```
# g = Graph.new(6)
# g.add 1, 2
# g.add 2, 3
# g.add 2, 4
# g.add 4, 5
# g.add 4, 6
# BipartiteMatching.new(g).solve # => 2
# ```
struct BipartiteMatching
  getter g : IGraph
  delegate n, to: g
  getter match : Array(Int32)
  getter seen : Array(Bool)

  def initialize(@g)
    @match = Array.new(n, -1)
    @seen = Array.new(n, false)
  end

  def initialize(pairs : Array(Tuple(Int, Int)))
    cc_from = CC.new(pairs.map &.[0])
    cc_to = CC.new(pairs.map &.[1])
    n = cc_from.size
    m = cc_to.size

    root = 0
    goal = n + m + 1
    @g = Graph.new(n + m + 2)

    # 始点から左ペアへのパス
    n.times do |i|
      g.add root, i + 1, origin: 0, both: false
    end

    # 右ペアから終点へのパス
    m.times do |i|
      g.add i + n + 1, goal, origin: 0, both: false
    end

    # 左ペアから右ペアへのパス
    pairs.each do |from, to|
      g.add cc_from[from] + 1, cc_to[to] + n + 1, origin: 0, both: false
    end

    pp! @g

    @match = Array.new(n + m + 2, -1)
    @seen = Array.new(n + m + 2, false)
  end

  def solve
    ans = 0
    match.fill(-1)

    g.each do |v|
      if match[v] < 0
        seen.fill(false)
        ans += 1 if dfs(v)
      end
    end

    {ans, match}
  end

  def dfs(v)
    seen[v] = true
    ret = false
    g.each(v) do |nv|
      next if ret
      w = match[nv]
      if w < 0 || !seen[w] && dfs(w)
        match[v] = nv
        match[nv] = v
        ret = true
      end
    end
    ret
  end
end
