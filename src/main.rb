MOD = 10**9+7

class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  attr_accessor :equl, :less
  def initialize
    @d = gets.to_s.to_i
    @s = gets.to_s.chomp
    @n = s.size
    # dp[決めた位置][Dの剰余] := 場合の数
    @equl = Array.new(n+1){ Array.new(d,0) }
    @less = Array.new(n+1){ Array.new(d,0) }
    equl[0][0] = 1
  end

  def each
    1.upto(n) do |i|
      num = s[i-1].to_i
      0.upto(d-1) do |mod|
        0.upto(9) do |digit|
          newmod = (mod + digit) % d
          yield i, num, newmod, mod, digit
        end
      end
    end
  end

  def init
    each do |i,num,newmod,mod,digit|
      if digit < num
        less[i][newmod] += less[i-1][mod]
        less[i][newmod] += equl[i-1][mod]
      elsif digit == num
        equl[i][newmod] += equl[i-1][mod]
        less[i][newmod] += less[i-1][mod]
      else
        less[i][newmod] += less[i-1][mod]
      end
      less[i][newmod] %= MOD
      equl[i][newmod] %= MOD
    end
  end
  
  def solve
    init
    equl[n][0] + less[n][0]
  end
  
  def show(ans)
    puts ans - 1
  end
end

Problem.new.instance_eval do
  show(solve)
end