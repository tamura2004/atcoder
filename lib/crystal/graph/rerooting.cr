require "crystal/weighted_tree/tree"

module WeightedTree
  struct Rerooting(T)
    getter g : Tree
    delegate n, to: g

    getter f1 : Proc(T, Int32, Int64, T)
    getter f2 : Proc(T, Int32, T)
    getter merge : Proc(T, T, T)

    getter dp : Array(Array(T))
    # dp_v = g(merge(f(dp_c1,c1),..f(dp_ck,ck)),v)

    getter unit : T # mergeの単位元

    def initialize(@g, @f1, @merge, @unit, @f2)
      @dp = Array.new(n) do |v|
        Array.new(g[v].size, unit)
      end
    end

    def dfs1(v, pv)
      ans = unit
      g[v].each_with_index do |(nv, cost), i|
        next if nv == pv
        dp[v][i] = dfs1(nv, v)
        ans = merge.call(ans, f1.call(dp[v][i], nv, cost))
      end
      f2.call(ans, v)
    end

    def dfs2(v, pv, from_par)
      g[v].each_with_index do |nv, i|
        if nv == pv
          dp[v][i] = from_par
          break
        end
      end

      nn = g[v].size
      right = Array.new(nn + 1, unit)
      g[v].zip(0..).reverse_each do |(nv, cost), i|
        right[i] = merge.call(right[i + 1], f1.call(dp[v][i], nv, cost))
      end

      left = Array.new(nn + 1, unit)
      g[v].each_with_index do |(nv, cost), i|
        left[i + 1] = merge.call(left[i], f1.call(dp[v][i], nv, cost))
      end

      g[v].each_with_index do |(nv, cost), i|
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
        g[v].zip(dp[v]).each do |(nv, cost), a|
          ans[v] = merge.call(ans[v], f1.call(a, nv, cost))
        end
        ans[v] = f2.call(ans[v], v)
      end
      ans
    end
  end
end
