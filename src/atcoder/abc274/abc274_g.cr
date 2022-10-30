require "crystal/flow_graph/dinic"

class Problem
  getter h : Int32
  getter w : Int32
  getter a : Array(Array(Int32))

  def initialize(@h, @w, @a)
  end

  def self.read
    h, w = gets.to_s.split.map(&.to_i)
    a = Array.new(h) do
      gets.to_s.chars.map(&.==('#').to_unsafe)
    end
    new(h, w, a)
  end

  def tiles(row)
    row.zip(0..).chunks(&.first).select(&.first.zero?).map(&.last.map(&.last))
  end

  def count_vertex
    ans = h * w + 2
    2.times do
      h.times do |y|
        ans += tiles(a[y]).size
      end
      @h, @w = w, h
      @a = a.transpose
    end
    ans
  end

  def solve
    n = count_vertex
    g = Graph.new(n)
    id = h * w + 2

    h.times do |y|
      tiles(a[y]).each do |xs|
        g.add 0, id, 1
        xs.each do |x|
          g.add id, to_v(y,x), 1
        end
        id += 1
      end
    end

    @a = a.transpose
    w.times do |x|
      tiles(a[x]).each do |ys|
        g.add id, 1, 1
        ys.each do |y|
          g.add to_v(y, x), id, 1
        end
        id += 1
      end
    end

    # g.debug
    Dinic.new(g).solve(0,1)
  end

  def to_v(y, x)
    y*w + x + 2
  end
end

pp Problem.read.solve
