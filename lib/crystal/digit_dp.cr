require "crystal/problem"

# 桁DPのテンプレート
#
# 数字丁度=EDGE、以後自由=FREE
class DigitDP(T) < Problem
  EDGE = 0
  FREE = 1

  getter n : Int32
  getter a : Array(Int32)

  def initialize(@n, @a)
  end

  # EDGE --just--> EDGE
  #      \-up----> FREE --not head--> FREE
  def each
    n.times do |i|
      [EDGE, FREE].each do |from|
        10.times do |d|
          to = from == EDGE && d == a[i] ? EDGE : FREE
          next if from == EDGE && d > a[i]
          next if from == FREE && to == FREE && i == 0
          yield i, from, to, d
        end
      end
    end
  end
end

# 桁DPの使用例
#
# 1以上*n*以下の整数であって、10進法で表した時に0出ない数字が
# 丁度*k*個あるものの個数を求めよ
#
# ```
# DigitDpProblem(Int64).read("314159 2").solve # => 937
# ```
class DigitDpProblem(T) < DigitDP(T)
  getter k : Int32

  def self.read(io : IO)
    a,k = io.gets.to_s.split
    a = a.chars.map(&.to_i)
    n = a.size
    k = k.to_i
    new(n, a, k)
  end

  def initialize(@n, @a, @k)
  end

  def solve
    dp = make_array(n + 1, k + 1, 2, T.zero)
    dp[0][EDGE][0] = T.new(1)
    
    # EDGE,FREE間の4パターンの遷移（うち一つ、FREE->EDGEは発生しない）
    # を、from, toに渡して列挙
    each do |i, from, to, d|
      0.upto(k) do |v|
        nv = v + (d != 0).to_unsafe
        next if nv > k

        dp[i + 1][nv][to] += dp[i][v][from]
      end
    end

    dp[-1][-1].sum
  end
end
