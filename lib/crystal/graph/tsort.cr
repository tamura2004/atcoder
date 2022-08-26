require "crystal/graph/i_graph"

class Tsort
  getter g : IGraph
  delegate n, to: g
  getter ind : Array(Int32)

  def initialize(@g)
    raise "有向グラフではありません #{g}" if g.both
    @ind = Array.new(n, 0)

    g.each do |v|
      g.each(v) do |nv|
        ind[nv] += 1
      end
    end
  end

  def solve
    ans = [] of Int32
    q = Deque(Int32).new

    ind.each_with_index do |count, v|
      q << v if count.zero?
    end

    while q.size > 0
      v = q.shift
      ans << v

      g.each(v) do |nv|
        ind[nv] -= 1
        q << nv if ind[nv].zero?
      end
    end

    ans
  end

  # ループがあるならnil
  # ないなら、トポロジカルソートの結果を返す
  def solve?
    solve.tap do |path|
      return nil if path.size < n
    end
  end

  # ループの有無のみ知りたい場合
  def has_loop?
    solve.size < n
  end

  def longest_path
    solve?.try do |path|
      depth = Array.new(n, 0)
      path.each do |v|
        g.each(v) do |nv|
          depth[nv] = depth[v] + 1
        end
      end

      depth
    end
  end
end
