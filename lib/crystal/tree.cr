# 木（重みなし）
class Tree
  getter n : Int32
  getter g : Array(Array(Int32))

  def initialize(@n)
    @g = Array.new(n) { [] of Int32 }
  end

  def read(io : IO = STDIN)
    (n - 1).times do
      i, j = io.gets.to_s.split.map(&.to_i.- 1)
      g[i] << j
      g[j] << i
    end
  end

  def read(input : String)
    read(IO::Memory.new(input))
  end

  # 頂点*init*から各点への最短距離を求める
  def bfs(init : Int32) : Array(Int32)
    q = Deque(Int32).new([init])
    dp = Array(Int32).new(n, -1)
    dp[init] = 0
    while q.size > 0
      v = q.shift
      g[v].each do |nv|
        next if dp[nv] != -1
        dp[nv] = dp[v] + 1
        q << nv
      end
    end
    return dp
  end
end
