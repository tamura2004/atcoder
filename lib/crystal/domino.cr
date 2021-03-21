require "crystal/problem"

# ABC196D Hanjo
#
# 愚直にDFSで解く
#
# ```
# Main.read("2 3 3 0").run # =>
# --|
# --|
#
# |--
# |--
#
# |||
# |||
# 3
# ```
class Main < Problem
  getter h : Int32
  getter w : Int32
  getter a : Int32
  getter b : Int32
  getter g : Array(Array(Int32))
  getter ans : Int32

  def initialize(@h, @w, @a, @b, @g)
    @ans = 0
  end

  def self.read(io : IO)
    h, w, a, b = io.gets.to_s.split.map(&.to_i)

    # 範囲の外側に枠を作り-1とする
    g = Array.new(h + 2) do |i|
      Array.new(w + 2) do |j|
        (i * j * (i - h - 1) * (j - w - 1)).sign.abs - 1
      end
    end

    new(h, w, a, b, g)
  end

  def solve
  end

  def print
    puts
    1.upto(h) do |i|
      1.upto(w) do |j|
        c = case
            when g[i][j] == 0           then "."
            when g[i][j] == g[i - 1][j] then "|"
            when g[i][j] == g[i + 1][j] then "|"
            when g[i][j] == g[i][j - 1] then "-"
            when g[i][j] == g[i][j + 1] then "-"
            end
        print c
      end
      puts
    end
  end

  # 上からi行目、左からj列めにid番の畳を置く
  def dfs(i, j, id)
    case
    when id > a      then count             # 置く枚数の条件を満たすならカウント
    when i > h       then nil               # 最終行画面外
    when j > w       then dfs(i + 1, 1, id) # 右端画面外なら次の行の左端へ
    when g[i][j] > 0 then dfs(i, j + 1, id) # セット済なら右へ
    else
      # 置かないなら右へ
      dfs(i, j + 1, id)

      # 右が空いていれば横に置く
      if g[i][j + 1] == 0
        g[i][j] = g[i][j + 1] = id
        dfs(i, j + 2, id + 1)
        g[i][j] = g[i][j + 1] = 0 # バックトラック
      end

      # 下が空いていれば縦に置く
      if g[i + 1][j] == 0
        g[i][j] = g[i + 1][j] = id
        dfs(i, j + 1, id + 1)
        g[i][j] = g[i + 1][j] = 0 # バックトラック
      end
    end
  end

  def count
    print
    @ans += 1
  end

  def run
    dfs(1, 1, 1)
    pp ans
    # pp self
    # puts solve
  end
end

Main.read("4 4 2 8").run
