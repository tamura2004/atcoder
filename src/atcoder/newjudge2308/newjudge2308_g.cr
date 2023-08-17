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
  Mid
end
keys = [] of Int64
events = [] of Tuple(Int64, Elevator, Int64)

buildings.flatten.each do |elevator|
  keys << elevator[0]
  keys << elevator[1]
  events << {elevator[0], Elevator::Lo, elevator[1]}
  events << {elevator[1], Elevator::Hi, elevator[1]}
end

# クエリを先読みして、キーには乗り降り階を含めておく
queries = Array.new(q) do
  x, y, z, w = gets.to_s.split.map(&.to_i64)
  keys << y
  keys << w
  events << {y, Elevator::Mid, 0_i64}
  events << {w, Elevator::Mid, 0_i64}
  {x, y, z, w}
end

# イベント列のソート
events.sort!
# pp! events

# 座標圧縮付き区間最大セグ木を作る
# ソート圧縮済のkeysを含む座標圧縮オブジェクトは取り出しておく
st = CCST(Int64, Int64).new(keys, ->Math.max(Int64, Int64))
cc = st.cc

# dpテーブルを埋める
# dp[keyのi番目にいるとき][あと2^j回で] := たどり着けるkeyのindex
# まずは(1)j=0をdpで求めて、(2)ダブリング

# (1)
dp = make_array(0, cc.size, 20)
events.each do |floor, side, hi|
  case side
  when .lo?
    st[hi] = hi
    dp[cc[floor]][0] = cc[st[floor..]]
  when .hi?
    dp[cc[floor]][0] = cc[st[floor..]]
  when .mid?
    st[floor] = floor
    dp[cc[floor]][0] = cc[st[floor..]]
  end
end

# (2)
(1...20).each do |j|
  cc.size.times do |i|
    dp[i][j] = dp[dp[i][j - 1]][j - 1]
  end
end

# ここまでくればもう一息、dpテーブルを利用して以下の通り
# 回数を0にセット
# 現在の階 < ゴールの階である間
#  | 2^19回移動 < ゴール = 答えなし
#  | 1回移動 >= ゴール = 回数 + 1が答え
#  | 1回移動 < ゴールなので
#  | 2分探索でゴールを越えない移動回数の最大のjを求める
#  | 回数に2^jを加える、現在の階をdp[現在の階][j]に変更
#
# 最初から、現在 <= ゴールにしておく
# コーナーケースは事前に排除
# 現在の階 => 現在のビルで登れる最大にしておく
# ゴール => ゴールのビルの一番下にしておく
# 現在 > ゴールなら、同じビルなら+0, 違うなら+1
queries.each do |x, y, z, w|
  # ビルxのy階から、ビルzのw階に移動
  x, y, z, w = z, w, x, y unless y <= w
  # pp cc.ref.zip(0..)

  x -= 1
  z -= 1
  ans = w - y

  # ビルx内のy階から乗れるエレベータを探して一番上へ
  # 乗れる == 上の階が自分以上
  if elevator = buildings[x].bsearch(&.[1].>= y)
    if elevator[0] <= y
      y = elevator[1]
    end
  end

  # ビル内のw階から乗れるエレベータを探して一番下へ
  if elevator = buildings[z].bsearch(&.[1].>= w)
    if elevator[0] <= w
      w = elevator[0]
    end
  end

  # コーナー
  if y >= w
    puts ans + (x != z).to_unsafe
    next
  end

  y = cc[y]
  w = cc[w]

  # pp! [y, w]
  # pp! dp[y]
  # pp! dp.map(&.[0]).zip(0..)

  # 2^19回移動 < ゴール = 答えなし
  if dp[y][-1] < w
    puts -1
    next
  end

  while y < w
    # 1回移動 >= ゴール = 回数 + 1が答え
    if dp[y][0] >= w
      puts ans + 2
      break
    end

    # 1回移動 < ゴールなので
    # 2分探索でゴールを越えない移動回数の最大のjを求める
    # 回数に2^jを加える、現在の階をdp[現在の階][j]に変更
    # コーナーつぶしているのでnot_nil!
    jj = (0...20).bsearch { |j| w <= dp[y][j] }.not_nil! - 1
    ans += 2 ** jj
    y = dp[y][jj]
  end
end
