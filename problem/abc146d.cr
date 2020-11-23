record Edge, from : Int32, to : Int32, id : Int32

class Tree
  getter n : Int32
  getter g : Array(Array(Edge))
  getter ans : Array(Int32)

  def self.read
    n = gets.to_s.to_i
    g = Array.new(n) { [] of Edge }
    (n - 1).times do |id|
      i, j = gets.to_s.split.map { |v| v.to_i - 1 }
      g[i] << Edge.new(i, j, id)
      g[j] << Edge.new(j, i, id)
    end
    new(n, g)
  end

  def initialize(@n, @g)
    @ans = Array.new(n - 1, -1)
  end

  # 親が無い（根である）
  # 　子のパスに、1から順に色を割り当てる
  # 親がある
  # 　親パスの色以外を順に割り当てる
  def solve
    q = Deque.new([{0,-1,-1}])
    while q.size > 0
      v, pv, c = q.shift
      i = 1
      g[v].each do |edge|
        next if edge.to == pv
        i += 1 if i == c
        ans[edge.id] = i
        q << ({edge.to, v, i})
        i += 1
      end
    end
    return ans
  end
end

ans = Tree.read.solve
puts ans.uniq.size
ans.each do |i|
  puts i
end
