class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)

  def initialize
    @h = 4
    @w = 7
  end

  def solve
  end

  def show(ans)
    puts ans
  end
end

Problem.new.instance_eval do
  show(solve)
end
