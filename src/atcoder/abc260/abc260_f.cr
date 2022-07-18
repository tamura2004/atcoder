require "crystal/graph"

class Problem
  getter s : Int32
  getter t : Int32
  getter m : Int32
  getter g : Graph
  delegate n, to: g

  def self.read
    s, t, m = gets.to_s.split.map(&.to_i)
    g = Graph.new(s + t)
    m.times do
      v, nv = gets.to_s.split.map(&.to_i64)
      g.add v, nv
    end
    new(s, t, m, g)
  end

  def initialize(@s, @t, @m, @g)
  end

  def solve
    cnt = Hash(Tuple(Int32, Int32), Int32).new
    s.times do |v|
      g[v].each_combination(2) do |(a, b)|
        a, b = b, a unless a < b
        pair = {a, b}

        if cnt.has_key?(pair)
          quit [v, a, b, cnt[pair]].map(&.succ).join(" ")
        else
          cnt[pair] = v
        end
      end
    end
    pp -1
  end
end

Problem.read.solve
