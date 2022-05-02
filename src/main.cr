# # 容量Tを持つ辺
# class Edge(T)
#   getter v : Int32
#   getter re : Int32
#   property cap : T

#   def initialize(@v, @re, @cap)
#   end
# end

# # 残余グラフ持ちグラフ
# class Graph(T)
#   getter n : Int32
#   getter g : Array(Array(Edge(T)))

#   delegate "[]", to: g

#   def initialize(n)
#     @n = n.to_i
#     @g = Array.new(n) { [] of Edge(T) }
#   end

#   def add(v, nv, cap, origin = 0)
#     v = v.to_i - origin
#     nv = nv.to_i - origin
#     cap = T.new(cap)

#     i = g[v].size  # これから追加する辺はi番目
#     j = g[nv].size # これから追加する辺はj番目

#     g[v] << Edge(T).new(nv, j, cap)
#     g[nv] << Edge(T).new(v, i, T.zero)
#   end
# end

# class MaxFlow(T)
#   getter g : Graph(T)
#   getter depth : Array(Int32)
#   getter visit : Array(Int32)

#   delegate n, to: g

#   def initialize(@g)
#     @depth = Array.new(n, -1)
#     @visit = Array.new(n, 0)
#   end

#   def solve(root = 0, goal = n - 1)
#     root = root.to_i
#     goal = goal.to_i

#     flow = T.zero

#     loop do
#       bfs(root)
#       return flow if depth[goal] < 0
#       visit.fill(0)

#       while (flowed = dfs(root, goal, T::MAX)) > 0
#         flow += flowed
#       end
#     end
#   end

#   def bfs(root)
#     depth.fill(-1)
#     depth[root] = 0
#     q = Deque.new([root])

#     while q.size > 0
#       v = q.shift

#       g[v].each do |e|
#         nv = e.v
#         cap = e.cap

#         next if depth[nv] != -1
#         next if cap <= T.zero
#         depth[nv] = depth[v] + 1
#         q << nv
#       end
#     end
#   end

#   def dfs(v, goal, flow)
#     return flow if v == goal
#     edges = g[v]

#     while visit[v] < edges.size
#       i = visit[v]
#       e = edges[i]
#       nv, re, cap = e.v, e.re, e.cap

#       if cap > 0 && depth[v] < depth[nv]
#         flowed = dfs(nv, goal, Math.min(flow, cap))
#         if flowed > 0
#           edges[i].cap -= flowed
#           g[nv][re].cap += flowed
#           return flowed
#         end
#       end
#       visit[v] += 1
#     end
#     T.zero
#   end
# end

require "crystal/flow_graph/max_flow"
include FlowGraph

n, m, p, q = gets.to_s.split.map(&.to_i64)
g = Graph.new(m + 1) # m == 魔導石

quit "Yes" if q.zero? && p.zero?
quit "No" if q.zero?

l = gets.to_s.split.map(&.to_i64)
l.each do |v|
  g.add m, v, p
end

n.times do
  v, nv, cap = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cap
end

ans = MaxFlow.new(g).solve(m, 0)
puts ans >= p ? "Yes" : "No"
