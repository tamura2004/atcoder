macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

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

  def [](y1,x1,y2,x2) : T
    cs[y2][x2] - cs[y2][x1] - cs[y1][x2] + cs[y1][x1]
  end
end

n,k = gets.to_s.split.map { |v| v.to_i }
k2 = k * 2
_black = Array.new(k2){ Array.new(k2, 0) }
_white = Array.new(k2){ Array.new(k2, 0) }

n.times do
  x,y,c = gets.to_s.split
  x = x.to_i % k2
  y = y.to_i % k2
  if c == "B"
    _black[y][x] += 1
  else
    _white[y][x] += 1
  end
end

b = CumulativeSum2D.new(_black)
w = CumulativeSum2D.new(_white)
ans = 0

k.times do |i|
  k.times do |j|
    cnt = b[0,0,i,j] +
     b[i,j,i+k,j+k] +
     b[i+k,j+k,k2,k2] +
     b[0,j+k,i,k2] +
     b[i+k,0,k2,j] +
     w[0,j,i,j+k] +
     w[i,0,i+k,j] +
     w[i,j+k,i+k,k2] +
     w[i+k,j,i+k,k2]
    chmax ans, cnt
    cnt = w[0,0,i,j] +
     w[i,j,i+k,j+k] +
     w[i+k,j+k,k2,k2] +
     w[0,j+k,i,k2] +
     w[i+k,0,k2,j] +
     b[0,j,i,j+k] +
     b[i,0,i+k,j] +
     b[i,j+k,i+k,k2] +
     b[i+k,j,i+k,k2]
    chmax ans, cnt
  end
end

puts ans

pp! b[0,0,k2,k2]
pp! w[0,0,k2,k2]