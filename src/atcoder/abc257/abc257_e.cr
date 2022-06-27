class Problem
  getter n : Int32
  getter c : Array(Int32)
  getter base_num : Int32
  getter base_cost : Int32
  getter ans : Array(Int32)

  def initialize(@n, @c)
    @base_cost = c.min
    @base_num = c.zip(0..).select(&.first.== base_cost).max.last
    @ans = Array.new(9, 0)
    ans[base_num], @n = n.divmod(base_cost)
  end

  def rec
    return if base_num == 8
    (base_num + 1...9).reverse_each do |i|
      diff_cost = c[i] - base_cost
      next if n < diff_cost

      diff_count = Math.min ans[base_num], n // diff_cost
      ans[base_num] -= diff_count
      ans[i] += diff_count
      @n -= diff_cost * diff_count
    end
  end

  def solve
    rec
  end

  def show
    solve
    quit 0 if ans.max.zero?

    cnt = [] of Int32
    ans.each_with_index do |v, i|
      v.times do
        cnt << i + 1
      end
    end
    puts cnt.sort.reverse.join
  end
end

n = gets.to_s.to_i
c = gets.to_s.split.map(&.to_i)
Problem.new(n, c).show
