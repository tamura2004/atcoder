require "crystal/indexable"
# dp(i)(go fuel)(back fuel) := min cost

n, h = gets.to_s.split.map(&.to_i64)
x = [0_i64] + gets.to_s.split.map(&.to_i64)

pf = Array.new(n - 1) {
  p, f = gets.to_s.split.map(&.to_i64)
  {p, f}
}

quit -1 if h < x[1]

dp = make_array(1e9.to_i64, n, h + 1, h + 1)
(h + 1).times do |back|
  break if h - x[1] < 0
  dp[0][h - x[1]][back] = 0_i64
end

(n - 1).times do |i|
  (h + 1).times do |go|
    (h + 1).times do |back|
      3.times do |j|
        case j
        when 0 # use go
          go_dist = x[i + 2] - x[i + 1]
          back_dist = x[i + 1] - x[i]
          if Math.min(h, go + pf[i][1]) - go_dist >= 0 && back + back_dist <= h
            chmin dp[i + 1][Math.min(h, go + pf[i][1]) - go_dist][back + back_dist], dp[i][go][back] + pf[i][0]
          end
        when 1 # use back
          go_dist = x[i + 2] - x[i + 1]
          back_dist = x[i + 1] - x[i]
          if go - go_dist >= 0 && back + back_dist <= h
            chmin dp[i + 1][go - go_dist][Math.max(0_i64, back + back_dist - pf[i][1])], dp[i][go][back] + pf[i][0]
          end
        when 2 # no use
          go_dist = x[i + 2] - x[i + 1]
          back_dist = x[i + 1] - x[i]
          if go - go_dist >= 0 && back + back_dist <= h
            chmin dp[i + 1][go - go_dist][back + back_dist], dp[i][go][back]
          end
        end
      end
    end
  end
end

ans = 1e9.to_i64
dist = x[-1] - x[-2]
(h + 1).times do |go|
  (h + 1).times do |back|
    if dist <= go - back
      chmin ans, dp[-1][go][back]
    end
  end
end
pp ans == 1e9.to_i64 ? -1 : ans
