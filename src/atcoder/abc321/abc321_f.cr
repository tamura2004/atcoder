require "crystal/st"
require "crystal/modint9"
require "crystal/ntt"

alias T = Array(ModInt)

q, k = gets.to_s.split.map(&.to_i64)

st = ST(T).new(
  values: Array.new(5000, nil.as(T?)),
  fxx: ->(x : T, y : T) {
    NTT.conv(x, y)
  }
)

cnt = Array.new(5001) { [] of Int32 }
id = 0

q.times do
  cmd, x = gets.to_s.split
  case cmd
  when "+"
    x = x.to_i
    cnt[x] << id

    dp = Array.new(x + 1, 0.to_m)
    dp[0] = 1.to_m
    dp[-1] = 1.to_m
    st[id] = dp
    id += 1

    if ans = st[0..][k]?
      pp ans
    else
      pp 0
    end
  when "-"
    x = x.to_i
    i = cnt[x].pop
    st[i] = nil

    if ans = st[0..][k]?
      pp ans
    else
      pp 0
    end
  end
end
