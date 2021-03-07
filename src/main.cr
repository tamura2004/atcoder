macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

pp DigitDP(Int32).read.solve

class DigitDP(T)
  EDGE = 0
  FREE = 1
  getter a : Array(Int32)
  getter n : Int32
  getter dp : Array(Array(Array(T)))

  def self.read
    a = gets.to_s.chars.map(&.to_i)
    n = a.size
    new(n, a)
  end

  def initialize(@n, @a)
    @dp = Array.new(n + 1) { Array.new(2) { Array.new(2, T.zero) } }
  end

  def solve
    rec
    dp
  end

  def rec
    each do |i, j, k|
      10.times do |d|
        break if j == EDGE && a[i] > d
        ii, jj, kk = nex(i, j, k, d)
        next if i == 0 && jj == FREE && kk == FREE && d >= a[i]
        chmax dp[ii][jj][kk], dp[i][j][k] + d
      end
    end
  end

  def each
    n.times do |i|
      [EDGE, FREE].each do |j|
        [EDGE, FREE].each do |k|
          yield i, j, k
        end
      end
    end
  end

  def nex(i, j, k, d)
    ii = i + 1
    jj = j == EDGE && d == a[i] ? EDGE : FREE
    kk = k == EDGE && d == 0 ? EDGE : FREE
    return ii, jj, kk
  end
end
