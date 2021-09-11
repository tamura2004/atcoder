class Problem
  getter v : Int32

  def initialize(@v)
  end

  def one
    initialize(10)
  end

  def two
    Problem.new(10)
  end
end

pp Problem.new(30).initialize(20).class
pp Problem.new(30).two.class