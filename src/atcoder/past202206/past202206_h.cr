# そもそもナップサックは、重さを状態として持つdpである
# ナップサックが二つなので、それぞれを状態として持つのは自然
# dp[i個決めた][j一つ目の重さ][k二つ目の重さ] := 価値の最大

n,a,b = gets.to_s.split.map(&.to_i64)
dp = make_array(0_i64, n+1,a+1,b+1)
items = Array.new(n) do
  gets.to_s.split.map(&.to_i64)
end

enum Action
  USE_A
  USE_B
  NONE
end

n.times do |i|
  w, v = items[i]

  (0..a).each do |j|
    (0..b).each do |k|
      Action.each do |act|
        jj = act.use_a? ? j + w : j
        kk = act.use_b? ? k + w : k
        next unless jj <= a
        next unless kk <= b

        chmax dp[i+1][jj][kk], dp[i][j][k] + (act.none? ? 0_i64 : v)
      end
    end
  end
end

pp dp[-1].flatten.max