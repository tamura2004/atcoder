require "crystal/indexable"
enum Kind
  Wall
  Hammer
  Root
  Goal
end

alias V = Tuple(Int32, Kind, Int32) # pos, kind, index

n, x = gets.to_s.split.map(&.to_i)

a = [] of V
a << {0, Kind::Root, -1}
a << {x, Kind::Goal, -1}

y = gets.to_s.split.map(&.to_i)
z = gets.to_s.split.map(&.to_i)

y.each_with_index do |v, i|
  a << {v, Kind::Wall, i}
end

z.each_with_index do |v, i|
  a << {v, Kind::Hammer, i}
end

a.sort!

ix = Array.new(n, -1) # ハンマーの位置
ir = -1               # スタート位置
ig = -1               # ゴール位置
a.each_with_index do |(pos, kind, j), i|
  if kind.hammer?
    ix[j] = i
  elsif kind.root?
    ir = i
  elsif kind.goal?
    ig = i
  end
end

INF = 1e15.to_i64
# INF = 1e3.to_i64
nn = a.size
dp = make_array(INF, nn, nn, 2)
dp[ir][ir][0] = 0_i64
dp[ir][ir][1] = 0_i64

nn.times do |offset|
  nn.times do |lo|
    hi = lo + offset
    next if nn <= hi

    2.times do |lr|
      next if dp[lo][hi][lr] == INF
      now = lr.zero? ? a[lo][0] : a[hi][0]

      [{lo - 1, hi, lo - 1, 0}, {lo, hi + 1, hi + 1, 1}].each do |nlo, nhi, k, nlr|
        next unless 0 <= nlo <= nhi < nn
        pos, kind, j = a[k]
        if !kind.wall? || (lo <= ix[j] <= hi)
          chmin dp[nlo][nhi][nlr], dp[lo][hi][lr] + (now - pos).abs
        end
      end
    end
  end
end

ans = nn.times.min_of do |i|
  2.times.min_of do |j|
    Math.min dp[i][ig][j], dp[ig][i][j]
  end
end

pp ans == INF ? -1 : ans
