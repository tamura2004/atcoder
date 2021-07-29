require "crystal/tree"

class Tree
  def centroid_decomposition_tree
    trees = [self]
    centroids = [] of Int32
    depth_counts_from_centroid = [] of Array(Int32)
    depth_counts_from_root = [] of Array(Int32)
    depth_from_root = [] of Array(Int32)
    dics = [] of Array(Tuple(Int32,Int32))
    g = self.class.new(1)

    q = Deque.new([0])
    while q.size > 0
      v = q.shift
      tree = trees[v]

      centroid, subtrees, dic = tree.centroid_decomposition
      centroids << centroid
      dics << dic.map { |tree_index, v| ({ tree_index + g.n, v }) }
      depth_counts_from_centroid << tree.depth_count(root: centroid, offset: 0)
      depth_counts_from_root << tree.depth_count(root: 0, offset: 1)
      depth_from_root << tree.depth(root: 0, offset: 1)

      subtrees.each do |subtree|
        trees << subtree
        q << g.n
        g.add_vertex(v, origin: 0)
      end
    end

    {
      trees,
      centroids,
      dics,
      depth_counts_from_centroid,
      depth_counts_from_root,
      depth_from_root,
      g
    }
  end
end

# n, qn = gets.to_s.split.map(&.to_i)

# g = Tree.new(n) do |g|
#   (n - 1).times do
#     v, nv = gets.to_s.split.map(&.to_i)
#     g.add v, nv
#   end
# end

# vk = (1..qn).map do
#   v, k = gets.to_s.split.map(&.to_i)
#   v -= 1
#   {v, k}
# end

N = 20000
n = N
g = Tree.make(N, :uni)

g.centroid_decomposition

# vk.each do |v, k|
#   if k == 0
#     puts 1
#     next
#   end

#   ans = 0_i64

#   q = Deque.new([{0,v}])

#   while q.size > 0
#     i,v = q.shift

#     st = sts[i]
#     c = cs[i]
#     dic = dics[i]
#     dcfc = dcfcs[i]
#     dcfr = dcfrs[i]
#     dfr = dfrs[i]

#     if c == v # 重心
#       ans += dcfc[k] if dcfc.size > k
#     else
#       ti, nv = dic[v]
#       d = k - dfrs[ti][nv]

#       if d >= 0
#         ans += dcfc[d] if dcfc.size > d
#         ans -= dcfrs[ti][d] if dcfrs[ti].size > d
#       end

#       q << {ti, nv}
#     end
#   end

#   puts ans
# end
