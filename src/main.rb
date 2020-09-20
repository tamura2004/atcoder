class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize
    @n = gets.to_s.to_i
    @a = Array.new(n){ gets.to_s.split.map { |v| v.to_i } }
  end

  def solve
    cnt = 0
    n.times do |i|
      if a[i][0] == a[i][1]
        cnt += 1 
      else
        cnt = 0
      end
      return "Yes" if cnt >= 3
    end
    "No"
  end

  def show(ans)
    puts ans
  end
end

Problem.new.instance_eval do
  show(solve)
end