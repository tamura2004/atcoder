require "crystal/graph"

struct Problem
  getter g : Graph
  getter ans : Array(Int32)
  getter seen : Array(Bool)
  delegate n, to: g

  def initialize(@g)
    @ans = Array.new(n, 0)
    @seen = Array.new(n, false)
  end

  def solve
    dfs(0)

    if ans[0] == 0
      v = g[0][0]
      ans[0], ans[v] = ans[v], ans[0]
    end
    ans
  end

  def dfs(v)
    return false if seen[v]
    seen[v] = true

    ch = [] of Int32
    g[v].each do |nv|
      ch << nv if dfs(nv)
    end

    case ch.size
    when 0
      true
    when 1
      nv = ch.first
      ans[nv], ans[v] = v, nv
      false
    else
      ch.each_with_index do |v, i|
        nv = ch[i - 1]
        ans[v] = nv
      end
      true
    end
  end
end

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n, m) do |g, i|
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv
end
ans = Problem.new(g).solve
puts ans.map(&.succ).join(" ")
