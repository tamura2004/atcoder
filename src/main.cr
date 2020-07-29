class Problem
  property :a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l, :m, :n, :o, :p, :q, :r, :s, :t, :u, :v, :w, :x, :y, :z

  @n : Int32
  @a : Array(Int64)

  def initialize
    @n = gets.to_s.to_i
    @a = gets.to_s.split.map(&.to_i64)
  end

  def solve
    a.sum
  end

  def show(ans)
    puts ans
  end
end

Problem.new.try do |me|
  me.show(me.solve)
end