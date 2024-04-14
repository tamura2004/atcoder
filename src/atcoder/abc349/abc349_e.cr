# DFS

INF = Int64::MAX

THREES = [
  0b111000000,
  0b000111000,
  0b000000111,
  0b100100100,
  0b010010010,
  0b001001001,
  0b100010001,
  0b001010100,
]

struct Int32
  def win?
    THREES.any? do |three|
      (self & three).popcount == 3
    end
  end

  def score(a : Array(Int64)) : Int64
    (0...9).sum do |i|
      a[i] * bit(i)
    end
  end
end

a = Array.new(3){ gets.to_s.split.map(&.to_i64) }.flatten

dfs = uninitialized Proc(Int32, Int32, Int32, Int64)
dfs = -> (my : Int32, your : Int32, turn : Int32) do
  sign = turn.even? ? 1_i64 : -1_i64

  # 末端処理（３並び）
  return INF * sign if my.win?
  return -INF * sign if your.win?

  # 末端処理（9手完了、未決着）
  return (my.score(a) - your.score(a)) * sign if turn == 9

  (0...9).max_of do |i|
    next -INF if (my | your).bit(i) != 0
    dfs.call(your, my | 1 << i, turn + 1) * sign
  end * sign
end

ans = dfs.call(0, 0, 0)
puts ans > 0 ? "Takahashi" : "Aoki"
