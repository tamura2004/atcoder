require "crystal/tree"
require "crystal/treap"

n = gets.to_s.to_i
c = gets.to_s.split.map(&.to_i)
st = Treap(Int32).new

g = Tree.new(n)
(n-1).times do
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv
end

ans = [] of Int32

dfs = uninitialized Proc(Int32,Int32,Nil)
dfs = ->(v : Int32, pv : Int32) do
  ans << v unless st.includes?(c[v])
  st << c[v]

  g[v].each do |nv|
    next if nv == pv
    dfs.call(nv, v)
  end

  st.delete(c[v])
end

dfs.call(0, -1)

puts ans.sort.map(&.succ).join("\n")