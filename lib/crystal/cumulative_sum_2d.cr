class CumulativeSum2D(T)
  getter cs : Array(Array(T))

  def initialize(a : Array(Array(T)))
    h = a.size
    w = a[0].size
    @cs = Array.new(h+1){ Array.new(w+1,T.zero) }

    h.times do |i|
      w.times do |j|
        cs[i+1][j+1] += cs[i+1][j] + cs[i][j+1] - cs[i][j] + a[i][j]
      end
    end
  end

  def sum(y1,x1,y2,x2)
    cs[y2][x2] - cs[y2][x1] - cs[y1][x2] + cs[y1][x1]
  end
end