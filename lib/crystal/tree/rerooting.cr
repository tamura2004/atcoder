require "crystal/tree"

struct Rerooting(T)
  getter g : Tree
  delegate n, to: g
  getter dp : Array(T)
  getter lo : Array(Array(T))
  getter hi : Array(Array(T))
  getter merge : Proc(T,T,T)
  getter apply : Proc(T,Int32,T)
  getter unit : T

  def initialize(tree @g, @merge, @apply, @unit)
    @dp = Array.new(n, unit)
    @lo = Array.new(n) do |v|
      Array.new(g[v].size + 1, unit)
    end
    @hi = Array.new(n) do |v|
      Array.new(g[v].size + 1, unit)
    end
  end

  def solve
    dfs1(0, -1)
    dfs2(0, -1, unit)
    dp
  end

  def dfs1(v, pv)
    ans = unit
    g[v].each_with_index do |nv, i|
      next if nv == pv
      dfs1(nv, v)
      cnt = lo[v][i + 1] = hi[v][i] = apply.call(dp[nv], nv)
      ans = merge.call ans, cnt
    end
    dp[v] = ans
  end

  def dfs2(v, pv, from_par)
    g[v].each_with_index do |nv, i|
      if nv == pv
        lo[v][i + 1] = from_par
        hi[v][i] = from_par
        dp[v] = merge.call dp[v], from_par
        break
      end
    end

    m = lo[v].size - 1
    0.upto(m - 1) do |i|
      lo[v][i + 1] = merge.call lo[v][i + 1], lo[v][i]
    end

    m.downto(1) do |i|
      hi[v][i - 1] = merge.call hi[v][i - 1], hi[v][i]
    end

    g[v].each_with_index do |nv, i|
      next if nv == pv
      cnt = apply.call(merge.call(lo[v][i], hi[v][i + 1]), v)
      dfs2(nv, v, cnt)
    end
  end
end