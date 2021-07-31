alias Pair = Tuple(Int32,Int64)

class Graph
  getter n : Int32
  getter g : Hash(Pair,Pair)
  getter t : Array(Array(Int64))

  def initialize(n)
    @n = n.to_i
    @g = Hash(Pair,Pair).new
    @t = Array.new(n){ [] of Int64 }
  end

  def add(v, vt, nv, nvt, origin = 1)
    v = v.to_i - origin
    nv = nv.to_i - origin

    g[{v, vt}] = {nv,nvt}

    # 出発時刻
    t[v] << vt
    t[v].sort!
  end
 
  # キューを利用した深さ優先検索
  #
  # yield v, 行き掛け := ENTER = 0
  # yield v, 帰り掛け := LEAVE = 1
  # def dfsq(v, vt)
  #   q = Deque.new([{~root, pv}, {root, pv}])

  #   while q.size > 0
  #     v, pv = q.pop
  #     if v < 0
  #       yield ~v, LEAVE, pv
  #     else
  #       yield v, ENTER, pv

  #       g[v].each do |nv|
  #         next if nv == pv
  #         q << {~nv, v}
  #         q << {nv, v}
  #       end
  #     end
  #   end
  # end
end

n,m,qn = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
m.times do
  a,b,s,t = gets.to_s.split.map(&.to_i64)
  g.add a,s,b,t
end

qn.times do
  x,y,z = gets.to_s.split.map(&.to_i64)
  y = y.to_i - 1

  q = Deque.new([{y,x,-1}])
  while q.size > 0
    v, t, pv = q.shift

    
    if z <= t
      if pv == -1
        puts v + 1
      else
        puts "#{pv+1} #{v+1}"
      end
      break
    end
    
    pp! [g.t[v], v]
    pp! g.t[v].bsearch_index(&.> t)
    unless bus = g.t[v].bsearch_index(&.> t)
      puts v + 1
    else
      st = g.t[v][bus]
      nv, nt = g.g[{v, st}]
      q << {nv, nt, v}
    end
  end
  exit
end



