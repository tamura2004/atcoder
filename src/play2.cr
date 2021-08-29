require "crystal/digit_dp"
require "crystal/mod_int"

_n, k = gets.to_s.split
a = _n.chars.map(&.to_i(16))
n = a.size
num = k.to_i

dp = make_array(0.to_m, n + 1, 17, 2, 2)
dp[0][0][0][0] = 1.to_m

# EDGEの頂点の累積集合
edge_num = Array.new(n + 1, 0)
n.times do |i|
  edge_num[i + 1] = edge_num[i] | (1 << a[i])
end

DigitDP.new(a, digit = 16).each_with_leading_zero_no_digit do |i, zero, edge|
  0.upto(17) do |kind|
    cur = dp[i][kind][edge][zero]

    case edge
    when EDGE
      a[i].times do |x|
      if i == 0 && x == 0
        dp[i+1][0][FREE][ZERO] += cur
      else
        

    when FREE
      dp[i + 1][kind + 1][edge][zero] += cur * kind
      
      case zero
      when NONZ
        dp[i + 1][kind + 1][edge][zero] += cur * (16 - kind)
      when ZERO
        dp[i+1][kind][edge][ZERO] += cur
        dp[i+1][kind+1][edge][NONZ] += cur * (16 - kind - 1)
      end
    end
  end
end
