require "crystal/graph/i_graph"

struct Rerooting(T)
  alias V = Int32 # 頂点番号
  alias E = Int32 # 辺番号

  getter g : IGraph
  delegate n, to: g

  getter f1 : (T, V, E) -> T
  getter f2 : (T, V) -> T
  getter merge : (T, T) -> T

  getter dp : Array(Array(T))
  # dp_v = f2(merge(f1(子の値,頂点番号j,辺番号k),..f1(dp_ik,ik,costk)),v)

  getter unit : T # mergeの単位元

  def initialize(@g, f1, @merge, @unit, f2)
    # 子からの状態遷移関数で、子の頂点番号、辺番号を省略可能にする
    @f1 = ->(a : T, i : Int32, j : Int32) do
      case f1
      when Proc(T, V, E, T) then f1.call(a, i, j)
      when Proc(T, V, T)    then f1.call(a, i)
      when Proc(T, T)       then f1.call(a)
      else                       a
      end
    end

    # 子の状態のマージから親の状態遷移関数で、親の頂点番号省略可能に
    @f2 = ->(a : T, i : Int32) do
      case f2
      when Proc(T, V, T) then f2.call(a, i)
      when Proc(T, T)    then f2.call(a)
      else                    a
      end
    end

    @dp = Array.new(n) do |v|
      Array.new(g.edges(v).size, unit)
    end
  end

  def dfs1(v, pv)
    ans = unit
    g.edges(v).each_with_index do |(nv, _, j), i|
      # g.each_cost_with_index(v) do |nv, cost, i|
      next if nv == pv
      dp[v][i] = dfs1(nv, v)
      ans = merge.call(ans, f1.call(dp[v][i], nv, j))
    end
    f2.call(ans, v)
  end

  def dfs2(v, pv, from_par)
    g.each_with_index(v) do |nv, i|
      if nv == pv
        dp[v][i] = from_par
        break
      end
    end

    edges = g.edges(v)

    nn = edges.size
    right = Array.new(nn + 1, unit)

    edges.zip(0..).reverse_each do |(nv, _, j), i|
      right[i] = merge.call(right[i + 1], f1.call(dp[v][i], nv, j))
    end

    left = Array.new(nn + 1, unit)
    edges.each_with_index do |(nv, _, j), i|
      left[i + 1] = merge.call(left[i], f1.call(dp[v][i], nv, j))
    end

    edges.each_with_index do |(nv, _, j), i|
      next if nv == pv
      val = merge.call(left[i], right[i + 1])
      dfs2(nv, v, f2.call(val, v))
    end
  end

  def debug
    pp! dp
  end

  def rec
    dfs1(0, -1)
    dfs2(0, -1, unit)
    dp
  end

  def solve
    rec
    ans = Array.new(n, unit)
    n.times do |v|
      edges = g.edges(v)

      edges.zip(dp[v]).each do |(nv, _, j), a|
        ans[v] = merge.call(ans[v], f1.call(a, nv, j))
      end
      ans[v] = f2.call(ans[v], v)
    end
    ans
  end
end
