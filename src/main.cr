class Problem
  property :a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l, :m, :n, :o, :p, :q, :r, :s, :t, :u, :v, :w, :x, :y, :z

  @n : Int32
  @k : Int32
  @x : Array(Int64)
  @y : Array(Int64)

  def initialize
    @n,@k = gets.to_s.split.map(&.to_i)
    @x,@y = Array.new(n){ gets.to_s.split.map(&.to_i64) }.transpose
  end

  def solve
    ans = 2_i64**62
    n.times do |ox|
      n.times do |dx|
        next unless x[ox] < x[dx]
        n.times do |oy|
          n.times do |dy|
            next unless y[oy] < y[dy]
            if k <= n.times.count do |i|
              x[ox] <= x[i] &&
              x[i] <= x[dx] &&
              y[oy] <= y[i] &&
              y[i] <= y[dy]
            end
              area = (x[ox]-x[dx]).abs*(y[oy]-y[dy]).abs
              ans = area if area < ans
            end
          end
        end
      end
    end
    ans
  end

  def show(ans)
    puts ans
  end
end

Problem.new.try do |me|
  me.show(me.solve)
end