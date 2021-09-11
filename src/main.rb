class Problem
  def initialize(v)
    @v = v
  end

  def one
    initialize(10)
  end

  def two
    Problem.new(10)
  end
end

pp Problem.new(30).one.class
pp Problem.new(30).two.class
