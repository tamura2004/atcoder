require "crystal/graph"

module Graph
  struct Tsort
    getter g : Graph
    getter ind : Array(Int32)
    delegate n, to: g

    def initialize(@g)
      @ind = Array.new(n, 0) # 入次数
      n.times do |v|
        g[v].each do |nv|
          ind[nv] += 1
        end
      end
    end
    
    def solve
      ans = [] of Int32
      q = Deque(V).new
      
      n.times do |v|
        q << v if ind[v].zero?
      end

      while q.size > 0
        v = q.shift
        ans << v

        g[v].each do |nv|
          ind[nv] -= 1
          q << nv if ind[nv].zero?
        end
      end

      ans
    end
  end
end
