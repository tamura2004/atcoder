class Tree
  getter n : Int32
  getter g : Array(Array(Tuple(Int32,Int32)))

  def self.read
    n = gets.to_s.to_i
    g = Array.new(n){ [] of Tuple(Int32,Int32) }
    (n-1).times do
      a,b,w = gets.to_s.split.map { |v| v.to_i }
      a -= 1
      b -= 1
      g[a] << {b,w}
      g[b] << {a,w}
    end
    new(n,g)
  end

  def initialize(@n,@g)
  end

  def solve
    seen = Array.new(n, -1)
    q = [0]
    seen[0] = 0
    while q.size > 0
      v = q.shift
      g[v].each do |nv,w|
        next if seen[nv] != -1
        seen[nv] = (seen[v] + w) % 2
        q << nv
      end
    end
    return seen
  end
end

t = Tree.read
ans = t.solve
puts ans.join("\n")
