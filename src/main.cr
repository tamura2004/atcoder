MOD = 10**9+7

class Problem
  property :d,:s,:n,:dp

  @d : Int32
  @s : String
  @n : Int32
  @dp : Array(Array(Array(Int64)))

  def initialize
    @d = gets.to_s.to_i
    @s = gets.to_s.chomp
    @n = s.size
    @dp = Array.new(n+1){ Array.new(d) { Array.new(2, 0_i64) } }
    dp[0][0][0] = 1
  end

  def each
    1.upto(n) do |i|
      num = s[i-1].to_i
      0.upto(d-1) do |from|
        0.upto(9) do |digit|
          to = (from + digit) % d
          yield dp[i-1][from],dp[i][to],num,digit
        end
      end
    end
  end

  def init
    each do |from,to,num,digit|
      if digit < num
        to[1] += from[1]
        to[1] += from[0]
      elsif digit == num
        to[0] += from[0]
        to[1] += from[1]
      else
        to[1] += from[1]
      end
      to[1] %= MOD
      to[0] %= MOD
    end
  end
  
  def solve
    init
    dp[n][0][0] + dp[n][0][1]
  end
  
  def show(ans)
    puts ans - 1
  end
end

Problem.new.try do |me|
  me.show(me.solve)
end