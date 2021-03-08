class DigitDP(T)
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

  def new_dp
    Array.new(n+1){ Array.new(2, T.zero) }
  end

  def new_dp(m)
    Array.new(n+1){ Array.new(m){ Array.new(2){ T.zero } } }
  end
end

class Problem(T) < DigitDP(T)
  def self.read
    a = gets.to_s.chars.map(&.to_i)
    n = a.size
    new(n, a)
  end

  def solve
    dp = new_dp(2)
    dp[0][0][0] = T.new(1)

    each do |i, from, to, d|
      2.times do |j|
        jj = j + (d == 4 || d == 9).to_unsafe
        jj = 1 if jj > 1
        dp[i + 1][jj][to] += dp[i][j][from]
      end
    end

    dp[-1][-1].sum
  end
end

a, b = gets.to_s.split.map(&.to_i64)
a = (a - 1).to_s.chars.map(&.to_i)
n = a.size
b = b.to_s.chars.map(&.to_i)
m = b.size
lo = Problem(Int64).new(n, a).solve
hi = Problem(Int64).new(m, b).solve
pp hi - lo
