require "crystal/priority_queue"
require "crystal/problem"

class Main < Problem
  alias Pair = Tuple(Int32, Int32)

  getter n : Int32
  getter k : Int32
  getter q : PriorityQueue(Pair) # foods not eat
  getter r : PriorityQueue(Pair) # foods eaten
  getter seen : Array(Bool)      # check foods eaten
  getter sat : Int64             # 種類ボーナス無しの満足度
  getter types : Int64             # 種類ボーナス無しの満足度

  def initialize(@n, @k, @q, @r, @seen, @sat, @types)
  end

  def self.read(io : IO)
    n, k = io.gets.to_s.split.map(&.to_i)
    q = PriorityQueue(Pair).lesser
    r = PriorityQueue(Pair).greater
    seen = Array.new(n, false)

    td = Array.new(n) do
      t, d = io.gets.to_s.split.map(&.to_i)
      t -= 1
      {d, t}
    end.to_a.sort.reverse

    sat = 0_i64
    types = 0_i64

    n.times do |i|
      d, t = td[i]
      if i < k
        sat += d
        if !seen[t]
          seen[t] = true
          types += 1
        else
          q << {d, t}
        end
      else
        if !seen[t]
          seen[t] = true
          r << {d, t}
        end
      end
    end

    new(n, k, q, r, seen, sat, types)
  end

  def solve
    ans = sat + types ** 2
    while q.size > 0 && r.size > 0
      qd,qt = q.pop
      rd,rt = r.pop
      @types += 1
      @sat += rd - qd

      chmax ans, sat + types ** 2
    end
    ans
  end

  def run
    # pp! self
    puts solve
  end
end

Main.read.run
