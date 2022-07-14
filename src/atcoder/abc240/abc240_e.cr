require "crystal/tree"

n = gets.to_s.to_i64
g = Tree.new(n)

(n-1).times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv
end

enter, leave = Problem.new(g).solve(0)
n.times do |i|
  puts "#{enter[i]} #{leave[i]}"
end

class Problem
  getter g : Tree
  delegate n, to: g
  getter enter : Array(Int32) 
  getter leave : Array(Int32) 
  getter id : Int32

  def initialize(@g)
    @enter = Array.new(n, -1)
    @leave = Array.new(n, -1)
    @id = 1_i64
  end

  def solve(root = 0)
    dfs(root, -1)
    {enter, leave}
  end

  def dfs(v, pv)
    enter[v] = id
    head = true

    g[v].each_with_index do |nv, i|
      next if nv == pv

      if head
        head = false
      else
        @id += 1
      end

      dfs(nv,v)
    end
    leave[v] = id
  end
end
