class Graph
  getter n : Int32
  getter m : Int32
  getter g : Array(Array(Int32))

  def self.read
    n,m = gets.to_s.split.map { |v| v.to_i }
    g = Array.new(n){ [] of Int32 }
    m.times do
      i,j = gets.to_s.split.map { |v| v.to_i - 1 }
      g[i] << j
      g[j] << i
    end
    new(n,m,g)
  end

  def initialize(@n,@m,@g)
  end

  def is_biparite?
    seen = Array.new(n, -1)
    n.times do |i|
      next if seen[i] != -1
      seen[i] = 0
      q = [i]
      while q.size > 0
        v = q.shift
        g[v].each do |nv|
          return false if seen[v] == seen[nv]
          next if seen[nv] != -1
          seen[nv] = 1 - seen[v]
          q << nv
        end
      end 
    end
    return true
  end
end

puts Graph.read.is_biparite? ? "Yes" : "No"