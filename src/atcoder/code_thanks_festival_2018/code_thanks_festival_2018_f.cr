# coins on the tree
require "crystal/graph"
require "crystal/graph/euler_tour"
require "crystal/graph/depth"

n, m, k = gets.to_s.split.map(&.to_i)
g = Graph.new(n, origin: 0)
root = -1

gets.to_s.split.map(&.to_i).each_with_index do |pv, v|
  if pv == 0
    root = v
  else
    g.add v, pv - 1, origin: 0
  end
end

el = EulerTour.new(g, root)
dep = Depth.new(g).solve(root).map(&.succ.to_i)
st = Array.new(n*2) do |i|
  v, ev = el.events[i]
  ev.enter? ? dep[v] : 0
end

valid = ->(k : Int32, m : Int32, a : Array(Int32)) do
  wk = a.select(&.> 0)
  return false if wk.size < m
  wk.sort!
  wk.first(m).sum <= k <= wk.last(m).sum
end

ans = [] of Int32

# k回の操作でm枚のコインを置く
solve = uninitialized (Int32, Int32) -> Nil
solve = ->(k : Int32, m : Int32) do
  return if m == 0
  n.times do |v|
    next if st[el.enter[v]] == 0
    tmp = st.dup

    (el.enter[v]..el.leave[v]).each do |i|
      tmp[i] = 0
    end

    if valid.call(k - dep[v], m - 1, tmp)
      ans << v
      st = tmp
      solve.call(k - dep[v], m - 1)
      break
    end
  end
end
solve.call(k, m)

puts ans.size == m ? ans.map(&.succ).join(" ") : -1
