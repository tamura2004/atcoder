require "crystal/graph"
require "crystal/graph/euler_tour"
require "crystal/graph/lca"
require "crystal/segment_tree"

# 隣接ノードとのパリティが問題になる場合で反転クエリがある時
# 区間の更新ではなく、両端の辺のみの更新で良い
# 特に部分木であれば、入口は根の一箇所なので、根と親のパス一ヶ所で良い

class PathQuery
  getter et : EulerTour
  getter lca : Lca

  def initialize(@et, @lca)
  end

  def solve(v, nv, st)
    t = lca.solve(v, nv).not_nil!
    st[..et.enter[v]] + st[..et.enter[nv]] - st[..et.enter[t]] * 2
  end
end

n = gets.to_s.to_i
g = Graph.new(n)

(n-1).times do |v|
  nv = gets.to_s.to_i
  g.add v+2, nv, origin: 1
end

et = EulerTour.new(g)
enter, leave = et.solve(0)
lca = Lca.new(g, 0)
pq = PathQuery.new(et,lca)

color = Array.new(n) do
  gets.to_s.to_i
end

# pp! enter
# pp! color

st = (n*2).to_st_sum

dfs = uninitialized Proc(Int32,Int32,Nil)
dfs = -> (v : Int32, pv : Int32) do
  g.each(v) do |nv|
    next if nv == pv
    if color[v] == color[nv]
      st[enter[nv]] = 1_i64
      st[leave[nv]] = -1_i64
    end
    dfs.call(nv,v)
  end
end
dfs.call(0, -1)

q = gets.to_s.to_i
q.times do
  cmd, v, nv = gets.to_s.split.map(&.to_i) + [0]
  v -= 1
  nv -= 1

  case cmd
  when 1
    next if v == 0
    # puts (0..2*n).map{|i|st[i]}.join(" ")
    st[enter[v]] = 1_i64 - st[enter[v]]
    st[leave[v]] = -1_i64 - st[leave[v]]
    # puts (0..2*n).map{|i|st[i]}.join(" ")
  when 2
    t = lca.solve(v,nv).not_nil!
    if pq.solve(v, nv, st) == 0
      puts "YES"
    else
      puts "NO"
    end
  end
end
