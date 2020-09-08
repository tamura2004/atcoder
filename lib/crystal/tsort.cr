class Graph(T)
  getter n : Int64
  getter g : Array(Array(T))
  forward_missing_to g

  def initialize(@n)
    @g = Array.new(n){ [] of T }
  end

  def tsort
    ans = [] of T
    ind = Array.new(n,0)
    n.times do |i|
      g[i].each do |j|
        ind[j] += 1
      end
    end
    q = [] of T
    n.times do |i|
      q << i if ind[i].zero?
    end
    while q.size > 0
      i = q.shift
      ans << i
      g[i].each do |j|
        ind[j] -= 1
        q << j if ind[j].zero?
      end
    end
    ans
  end
end
