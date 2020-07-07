MOD = 10**9+7
class Problem
  attr_accessor :a, :b, :c, :n, :m, :k, :h, :w, :x, :y, :ans, :q
  def initialize
    @n, @k = gets.to_s.split.map{ |v| v.to_i }
    @a = gets.to_s.split.map{ |v| v.to_i }
    @plus = @a.select{ _1 > 0 }.sort!.reverse!
    @double = @plus.each_slice(2).map{|s,t|s*t}
    @double_o = @double.dup
    @m = @a.select{ _1 < 0 }.sort!
    @minus = @m.each_slice(2).map{|s,t|s*t}
    @minus_o = @minus.dup
  end

  def solve
    i = 0
    j = 0
    while i + j < k / 2
      if @double.size > 0
        if @minus.size > 0
          if @double[i] > @minus[j]
            i += 1
            @double.shift
          else
            j += 1
            @minus.shift
          end
        else
          i += 1
          @double.shift
        end
      else
        if @minus.size > 0
          j += 1
          @minus.shift
        else
          raise "err"
        end
      end
    end
    @i = i * 2
    @j = j
    if k - (@i + @j * 2) > 0
      if @plus.size > @i
        @i += 1
      end
    end

    ans = 1
    @j.times do |j|
      ans *= @minus_o[j]
      ans %= MOD
    end
    @i.times do |i|
      ans *= @plus[i]
      ans %= MOD
    end
    puts ans
  end
end

pb = Problem.new
pb.solve
pp pb if ENV['USER'] == "tamura"