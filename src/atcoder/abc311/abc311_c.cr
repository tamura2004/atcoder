# dfsをして後退辺を見つけたら、その先をrootとしてrootまで巻き戻す

require "crystal/graph"

n = gets.to_s.to_i64
g = n.to_g

gets.to_s.split.map(&.to_i64).each_with_index do |v, i|
  g.add i, v.pred, both: false, origin: 0
end

ans = [] of Int32
seen = Array.new(n, false)
seen[0] = true
root = -1

dfs = uninitialized (Int32) -> Nil
dfs = -> (v : Int32) do
  g.each(v) do |nv|
    if seen[nv]
      root = nv
      next
    end
    seen[nv] = true
    dfs.call(nv)
  end
  if v == root
    ans << v
    puts ans.size
    puts ans.reverse.map(&.succ).join(" ")
    exit
  else
    ans << v
  end
end
dfs.call(0)