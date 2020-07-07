class Problem
  @a : Int64
  @b : Int64
  @ans : Int64

  property :a, :b, :ans

  def initialize
    @a, @b = gets.to_s.split.map(&.to_i64)
  end

  def solve
    @ans = a * b
  end

  def show
    puts ans
  end
end

b = Problem.new
b.solve
b.show
