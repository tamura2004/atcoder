require "crystal/tree"

# オイラーツアー
# https://maspypy.com/euler-tour-%E3%81%AE%E3%81%8A%E5%8B%89%E5%BC%B7
# [1] - [2] - [3] - [4]
#   \[6] \[5]
#
# enter 0 1 2 4 6 9
# leave 11 8 5 5 7 10
# index 1 2 3 4 -4 -3 5 -5 -2 6 -6 -1
class EulerTour
  getter n : Int32
  getter g : Tree

  getter enter : Array(Int32)
  getter leave : Array(Int32)
  getter index : Array(Int32)

  def initialize(@g)
    @n = g.n

    @enter = [-1] * n
    @leave = [-1] * n
    @index = [] of Int32

    dfs(0)
  end

  def dfs(v)
    enter[v] = index.size
    index << v + 1

    g[v].each do |nv|
      next if enter[nv] != -1
      dfs(nv)
    end

    leave[v] = index.size
    index << -(v + 1)
  end
end