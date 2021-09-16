require "crystal/graph"

module Graph
  # 有向グラフのトポロジカルソート
  #
  # ```
  # g = Graph.new(4)
  # g.add 3, 1
  # g.add 1, 2
  # g.add 1, 4
  # Tsort.new(g).solve      # => [3, 1, 2, 4]
  # Tsort.new(g).have_loop? # => false
  # ```
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

    # トポロジカルソート
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

    # ループの有無
    def have_loop?
      solve.size < n
    end
  end
end
