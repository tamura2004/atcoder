class Problem
  property :n, :dp
  @n : Int32
  @dp : Array(Int32)

  def initialize
    @n = gets.to_s.to_i
    @dp = Array.new(n+1){|i|i}
  end
  
  def solve
    rec6
    rec9
    dp[n]
  end

  def rec6
    n.times do |i|
      1.upto(7) do |j|
        d = 6 ** j
        1.upto(5) do |k|
          e = d * k
          next if n < i + e
          dp[i + e] = dp[i] + k if dp[i + e] > dp[i] + k
        end
      end
    end
  end

  def rec9
    n.times do |i|
      1.upto(6) do |j|
        d = 9 ** j
        1.upto(8) do |k|
          e = d * k
          next if n < i + e
          dp[i + e] = dp[i] + k if dp[i + e] > dp[i] + k
        end
      end
    end
  end

  def show(ans)
    puts ans
  end
end

Problem.new.try do |b|
  b.show(b.solve)
end

