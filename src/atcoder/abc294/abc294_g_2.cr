require "crystal/segment_tree"
require "crystal/graph"

class EulerTour
  getter g : Graph
  delegate n, to: g
  getter enter : Array(Int32)
  getter leave : Array(Int32)
  getter visit : Array(Int32)
  getter depth : Array(Int32)
  getter st : SegmentTree(Tuple(Int32,Int32))

  def initialize(@g)
    @enter = Array.new(n, -1)
    @leave = Array.new(n, -1)
    @visit = [] of Int32
    @depth = [] of Int32
    dep = 0

    dfs = uninitialized (Int32, Int32) -> Nil
    dfs = -> (v : Int32, pv : Int32) do
      enter[v] = visit.size
      visit << v
      depth << dep
      dep += 1
      g.each(v) do |nv|
        next if nv == pv
        dfs.call(nv, v)
      end
      leave[v] = visit.size
      visit << v
      dep -= 1
      depth << dep
    end
    dfs.call(0, -1)

    values = depth.zip(visit)
    unit = {Int32::MAX,Int32::MAX}
    @st = SegmentTree(Tuple(Int32,Int32)).new(
      values: values,
      unit: unit,
    ) { |x,y| x < y ? x : y }
  end

  def lca(v, nv)
    st[enter[v]..enter[nv]][1]
  end
end

n = 4
g = n.to_g
g.add 1, 2
g.add 2, 3
g.add 2, 4

et = EulerTour.new(g)
pp et.lca(2,3)



# n = gets.to_s.to_i
# g = n.to_g
# (n-1).times do
#   v,nv,cost = gets.to_s.split.map(&.to_i64)
#   g.add v, nv, cost
# end
