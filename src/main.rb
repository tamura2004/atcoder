class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize
    @x = gets.chomp
    @s = gets.chomp
  end

  def solve
    s.gsub(x,"")
  end

  def show(ans)
    puts ans
  end
end

Problem.new.instance_eval do
  show(solve)
end