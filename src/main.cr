macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

class CumulativeSum2D(T)
  getter cs : Array(Array(T))

  def initialize(a : Array(Array(T)))
    h = a.size
    w = a[0].size
    @cs = Array.new(h + 1) { Array.new(w + 1, T.zero) }

    h.times do |i|
      w.times do |j|
        cs[i + 1][j + 1] += cs[i + 1][j] + cs[i][j + 1] - cs[i][j] + a[i][j]
      end
    end
  end

  def [](y1, x1, y2, x2) : T
    cs[y2][x2] - cs[y2][x1] - cs[y1][x2] + cs[y1][x1]
  end
end

n, k = gets.to_s.split.map { |v| v.to_i }
cnt = Array.new(2) { Array.new(k) { Array.new(k, 0) } }

n.times do
  x, y, c = gets.to_s.split
  x = x.to_i
  y = y.to_i
  c = c == "B" ? 1 : 0
  i = ((x//k) + (y//k) + c) % 2
  cnt[i][y % k][x % k] += 1
end

cs = Array.new(2) { |i| CumulativeSum2D.new(cnt[i]) }
ans = k.times.max_of do |i|
  k.times.max_of do |j|
    2.times.max_of do |c|
      cs[c][0, 0, i, j] + cs[c][i, j, k, k] + cs[1 - c][0, j, i, k] + cs[1 - c][i, 0, k, j]
    end
  end
end

puts ans
