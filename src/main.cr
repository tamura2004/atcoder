
UNKNOWN = -1
WIN = 0
LOSE = 1

class Graph
  getter n : Int32
  getter g : Array(Array(Int32))
  getter head : Hash(String,Array(Int32))
  getter tail : Hash(String,Array(Int32))
  getter ind : Array(Int32)
  getter outd : Array(Int32)
  getter win : Array(Bool)
  getter seen : Array(Bool)
  
  def initialize
    @n = gets.to_s.to_i
    @ind = Array.new(n, 0)
    @outd = Array.new(n, 0)
    @win = Array.new(n, false)
    @seen = Array.new(n, false)

    @head = Hash(String,Array(Int32)).new do |h,k|
      h[k] = [] of Int32
    end

    @tail = Hash(String,Array(Int32)).new do |h,k|
      h[k] = [] of Int32
    end

    n.times do |i|
      s = gets.to_s
      h = s[0,3]
      t = s[-3,3]
      head[h] << i
      tail[t] << i
    end

    @g = Array.new(n){ [] of Int32 }

    keys = head.keys & tail.keys
    keys.each do |key|
      head[key].each do |nv|
        tail[key].each do |v|
          g[v] << nv
          ind[nv] += 1
          outd[v] += 1
        end
      end
    end
  end

  # vを取ることが勝ちである
  def dfs(v)
    return nil if seen[v]
    seen[v] = true

    # どこにも行けないなら、勝ち
    if g[v].empty?
      win[v] = true
    else
      win[v] = g[v].all? do |nv|
        dfs(nv)
      end
      win[v] = !win[v]
    end
  end
end

g = Graph.new
pp g.dfs(2)

pp g