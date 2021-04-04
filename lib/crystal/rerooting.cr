require "crystal/tree"

macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

n = gets.to_s.to_i
a = Array.new(n-1){ gets.to_s.to_i }
g = Main.new(n)
g.read_plist(a)
puts g.solve.join("\n")

class Main < Tree
  def solve
    tsort!

    dp = Array.new(n, 1) # 部分木の状態
    ans = Array.new(n, 0) # 部分木の答え

    dfs do |v, nv|
      dp[v] += dp[nv]
      chmax ans[v], dp[nv]
    end

    bfs do |v, nv|
      chmax ans[nv], dp[v] - dp[nv]
      dp[nv] = dp[v]
    end

    return ans
  end
end
