macro make_array(i,v)
  Array.new({{i}}){ {{v}} }
end

macro make_array(i,j,v)
  Array.new({{i}}){ Array.new({{j}}){ {{v}} } }
end

macro make_array(i,j,k,v)
  Array.new({{i}}){ Array.new({{j}}){ Array.new({{k}}){ {{v}} } } }
end

macro make_array(i,j,k,l,v)
  Array.new({{i}}){ Array.new({{j}}){ Array.new({{k}}){ Array.new({{l}}){ {{v}} } } } }
end

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
end

class ABC154(T) < DigitDP(T)
  def self.read
    a = gets.to_s.chars.map(&.to_i)
    n = a.size
    new(n, a)
  end

  def solve
    m = gets.to_s.to_i
    dp = make_array(n+1, m+1, 2, T.zero)
    dp = Array.new(n + 1) { Array.new(m + 1) { Array.new(2, T.zero) } }
    dp[0][EDGE][0] = T.new(1)

    each do |i, from, to, d|
      0.upto(m) do |v|
        nv = v + (d != 0).to_unsafe
        next if nv > m

        dp[i + 1][nv][to] += dp[i][v][from]
      end
    end

    dp[-1][-1].sum
  end
end

pp ABC154(Int64).read.solve