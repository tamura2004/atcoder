macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

class Tree
  getter n : Int32
  getter g : Array(Array(Int32))
  getter memo : Array(Array(Int32))
  
  def initialize(@n,@g)
  end
  
  def self.read
    n = gets.to_s.to_i
    g = Array.new(n){ [] of Int32 }
    (n-1).times do
      i,j = gets.to_s.split.map { |v| v.to_i }
      g[i] << j
      g[j] << i
    end
    new(n,g)
  end

  def dfs(v,pv)
    ans = 0
    g[v].each do |nv|
      next if nv == pv
      chmax ans, dfs(nv,v)
    end
    return ans + 1
  end
end

pp Tree.read.dfs(0,-1)