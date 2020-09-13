class Problem
  getter n : Int32
  getter a : Array(Int64)
  getter b : Array(Int64)
  
  def initialize
    @n = gets.to_s.to_i
    @a = gets.to_s.split.map { |v| v.to_i64 }
    @b = gets.to_s.split.map { |v| v.to_i64 }
  end

  def count
    cnt = Hash(Int64,Int32).new(0)
    a.each do |i|
      cnt[i] += 1
    end
    b.each do |i|
      cnt[i] += 1
    end
    cnt.values.max
  end

  def solve
    return [] of Int64 if n < count
    c = [] of Int64
    while b.size > 0
      if a[c.size] != b[0]
        c << b.shift
      else
        c << b.pop
      end
    end
    c
  end

  def show(ans)
    if ans.empty?
      puts "No"
    else
      puts "Yes"
      puts ans.join(" ")
    end
  end

  def instance_eval
    with self yield
  end
end

Problem.new.instance_eval do
  show(solve)
end