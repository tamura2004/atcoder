require "crystal/graph"

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
  getter g : Graph
  delegate n, to: g
  getter match : Array(Int32)
  getter seen : Array(Bool)

  def initialize(@g)
    @match = Array.new(n, -1)
    @seen = Array.new(n, false)
  end

  def solve
    ans = 0
    match.fill(-1)

    n.times do |v|
      if match[v] < 0
        seen.fill(false)
        ans += 1 if dfs(v)
      end
    end

    { ans, match }
  end

  def dfs(v)
    seen[v] = true
    g[v].each do |nv|
      w = match[nv]
      if w < 0 || !seen[w] && dfs(w)
        match[v] = nv
        match[nv] = v
        return true
      end
    end
    false
  end
end
