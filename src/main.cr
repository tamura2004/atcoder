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

macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

h,w,k,v = gets.to_s.split.map { |v| v.to_i64 }
a = Array.new(h){ gets.to_s.split.map { |v| v.to_i64 } }
cs = CumulativeSum2D(Int64).new(a)
ans = 0_i64
h.times do |y|
  w.times do |x|
    1.upto(h-y) do |dy|
      1.upto(w-x) do |dx|
        s = dy * dx
        cost = cs.sum(y,x,y+dy,x+dx) + s * k
        if cost <= v
          chmax ans, s
        end
      end
    end
  end
end

pp ans