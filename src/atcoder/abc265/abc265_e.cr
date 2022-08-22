require "crystal/modint9"
require "crystal/complex"

n, m = gets.to_s.split.map(&.to_i64)
values = gets.to_s.split.map(&.to_i64)
a = values.in_groups_of(2).map(&.to_c)
dp = make_array(0.to_m, n+1, n+1, n+1)
dp[0][0][0] = 1.to_m

ng = (0...m).map do
  C.read
end.to_set

ans = 0.to_m

(0..n).each do |i|
  (0..i).each do |s|
    (0..i - s).each do |t|
      u = i - s - t
      w = a.zip({s, t, u}).sum { |a, b| a*b }

      if i == n
        ans += dp[i][s][t]
      else
        3.times do |j|
          z = w + a[j]
          next if ng.includes?(z)
          ii = i + 1

          ss = s
          tt = t

          ss += 1 if j == 0
          tt += 1 if j == 1

          dp[ii][ss][tt] += dp[i][s][t]
        end
      end
    end
  end
end

pp ans
