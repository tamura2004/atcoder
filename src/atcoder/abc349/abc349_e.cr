# min-max法
# 局面の勝ち=Inf、t-a、
# 状態でDP 3 ** 9 == 19683
# T - A 勝ち負けはINF
# 手番の偶数奇数で最大か最小を選ぶ
# 逆順

a = Array.new(3) { gets.to_s.split.map(&.to_i64) }.flatten

score = ->(s : Int32) {
  a.zip(0..).sum do |v, i|
    v * s.bit(i)
  end
}

masks = [
  0b111000000,
  0b000111000,
  0b000000111,
  0b100100100,
  0b010010010,
  0b001001001,
  0b100010001,
  0b001010100,
]

win = ->(s : Int32) {
  masks.any? do |mask|
    (mask & s).popcount == 3
  end
}

dp = Array.new(1 << 9) do |taka|
  Array.new(1 << 9) do |aoki|
    if (taka.popcount + aoki.popcount).odd?
      Int64::MAX
    else
      Int64::MIN
    end
  end
end

hands = (1 << 9).times.to_a

hands.reverse_each do |taka|
  hands.reverse_each do |aoki|
    next unless taka & aoki == 0

    tc, ac = [taka, aoki].map(&.popcount)
    next unless 0 <= tc - ac <= 1

    tw, aw = [taka, aoki].map { |s| win.call(s) }
    next if tw && aw

    if tw
      dp[taka][aoki] = Int64::MAX
    elsif aw
      dp[taka][aoki] = Int64::MIN
    elsif tc + ac == 9
      dp[taka][aoki] = score.call(taka) - score.call(aoki)
    else
      if tc == ac
        # takahashi turn
        9.times do |i|
          next if taka.bit(i) == 1
          next if aoki.bit(i) == 1
          chmax dp[taka][aoki], dp[taka | 1 << i][aoki]
        end
      else
        # aoki turn
        9.times do |i|
          next if taka.bit(i) == 1
          next if aoki.bit(i) == 1
          chmin dp[taka][aoki], dp[taka][aoki | 1 << i]
        end
      end
    end
  end
end
puts dp[0][0] > 0 ? :Takahashi : :Aoki
