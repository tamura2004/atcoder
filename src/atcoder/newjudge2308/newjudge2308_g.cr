require "crystal/coodinate_compress_segment_tree"

n, m, q = gets.to_s.split.map(&.to_i)
buildings = Array.new(n) { [] of Tuple(Int64, Int64) }

# ビルごとにエレベータを読み込んでまとめる
m.times do
  i, lo, hi = gets.to_s.split.map(&.to_i64)
  i -= 1
  buildings[i] << {lo, hi}
end

# ビル毎のエレベーターの重複を排除しつつ昇順にソート
buildings.map! do |elevators|
  elevators.sort!
  nex = [] of Tuple(Int64, Int64)
  elevators.each do |elevator|
    if nex.empty? || nex[-1][1] < elevator[0]
      nex << elevator
    else
      last = nex.pop
      nex << {last[0], Math.max last[1], elevator[1]}
    end
  end
  nex
end

# 全エレベータの下階、上階をまとめてイベント列とキーを作る
enum Elevator
  Lo
  Hi
end
keys = [] of Int64
events = [] of Tuple(Int64, Elevator, Int64)

buildings.flatten.each do |elevator|
  keys << elevator[0]
  keys << elevator[1]
  events << {elevator[0], Elevator::Lo, elevator[1]}
  events << {elevator[1], Elevator::Hi, elevator[1]}
end
events.sort!

# 座標圧縮付き区間最大セグ木を作る
st = CCST(Int64, Int64).new(keys, ->Math.max(Int64, Int64))

# dp[keyのi番目にいるとき][あと2^j回で] := たどり着けるkeyのindex
# まずは(1)j=0をdpで求めて、(2)ダブリング

# (1)
dp = make_array(0, st.cc.size, 20)
events.each do |floor, side, hi|
  case side
  when .lo?
    st[hi] = hi
    dp[st.cc[floor]][0] = st.cc[st[floor..]]
  when .hi?
    dp[st.cc[hi]][0] = st.cc[st[hi..]]
  end
end

# (2)
(1...20).each do |j|
  st.cc.size.times do |i|
    dp[i][j] = dp[dp[i][j - 1]][j - 1]
  end
end

#
pp! dp[0]
