class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize
    @n = gets.to_s.to_i
    @a = gets.to_s.split.map{ |v| v.to_i }
    @h = a.tally
    @t = h.map{|k,v|v*(v-1)/2}.sum
  end

  def solve
    n.times.map do |i|
      t - h[a[i]] + 1
    end
  end

  def show(ans)
    ans.each do |v|
      puts v
    end
  end
end

Problem.new.instance_eval do
  show(solve)
  # pp self
end

# n * (n-1) / 2
# - (n-1) * (n-2) / 2
# = n-1