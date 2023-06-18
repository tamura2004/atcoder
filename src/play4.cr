require "crystal/graph"

class SCC
  getter g : Graph
  getter rg : Graph
  delegate n, to: g
  getter seen : Array(Bool)
  getter seen_rev : Array(Bool)

  def initialize(@g,@rg)
    @seen = Array.new(n, false)
    @seen_rev = Array.new(n, false)
  end

  def solve
    ans = n.to_g

    # 頂点0から正順で辿り着ける頂点をマーク
    seen[0] = true
    q = Deque.new([0])
    while q.size > 0
      v = q.shift
      g.each(v) do |nv|
        next if seen[nv]
        seen[nv] = true
        q << nv
      end
    end

    # 逆順
    q << 0
    seen_rev[0] = true
    while q.size > 0
      v = q.shift
      rg.each(v) do |nv|
        if seen[nv]
          ans.add nv, v, both: false, origin: 0
        end

        next if seen_rev[nv]
        seen_rev[nv] = true
        q << nv
      end
    end
    ans
  end
end

g = 6.to_g
rg = 6.to_g

g.add 0, 1, both: false, origin: 0
g.add 1, 2, both: false, origin: 0
g.add 2, 0, both: false, origin: 0
g.add 1, 3, both: false, origin: 0
g.add 3, 4, both: false, origin: 0
g.add 4, 5, both: false, origin: 0
g.add 5, 3, both: false, origin: 0

rg.add 1, 0, both: false, origin: 0
rg.add 2, 1, both: false, origin: 0
rg.add 0, 2, both: false, origin: 0
rg.add 3, 1, both: false, origin: 0
rg.add 4, 3, both: false, origin: 0
rg.add 5, 4, both: false, origin: 0
rg.add 3, 5, both: false, origin: 0

ans = SCC.new(g,rg).solve
ans.each do |v|
  ans.each(v) do |nv|
    puts "#{v}, #{nv}"
  end
end
