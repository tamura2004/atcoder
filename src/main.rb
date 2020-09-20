class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize
    @n = gets.to_s.to_i
    @a = gets.split.map(&:to_i)
  end

  def solve
    a.sum
  end

  def show(ans)
    puts ans
  end
end

Problem.new.instance_eval do
  show(solve)
end