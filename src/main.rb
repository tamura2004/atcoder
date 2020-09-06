# 区間 [a,b)
class Segment
  attr_accessor :a,:b,:values
  def initialize(a,b)
    @a = a
    @b = b
    if block_given?
      @values = Array.new(b-a) { |i| yield a + i }
    else
      @values = Array.new(b-a)
    end
  end

  # [a,b)でmの倍数である添え字を列挙
  def each_measure(m)
    n = (a + m - 1) / m * m # a以上の最小のmの倍数
    n.step(b-1,m) do |i|
      yield i
    end
  end

  def [](i); check_error(i); values[i-a]; end
  def []=(i,j); check_error(i); values[i-a] = j; end
  def check_error(i)
    # raise "index must be in range: #{a} <= #{i} < #{b}" if i < a || b <= i
  end
end

class Problem
  EPS = 0.1
  attr_accessor :a,:b,:n,:big_value,:big_num,:small
  def initialize
    @a,@b = gets.split.map(&:to_i)
    @n = (Math.sqrt(b+1) + EPS).ceil
    @small = Segment.new(2,n) { true }
    @big_value = Segment.new(a,b+1) { |i| i } # 値、約数の個数
    @big_num = Segment.new(a,b+1) { 0 } # 値、約数の個数
  end
  
  def init
    (2...n).each do |i|
      next unless small[i]
      (i*i).step(n-1,i) do |j|
        small[j] = false
      end
      big_value.each_measure(i) do |j|
        while big_value[j] % i == 0
          big_value[j] /= i
          big_num[j] += 1
        end
      end
    end
  end

  def solve
    init
    ans = 0
    (b-a).times do |i|
      cnt = big_num.values[i]
      cnt += 1 if big_value.values[i] != 1
      ans += 1 if valid?(cnt)
    end
    ans
  end

  def valid?(i)
    return false if i < 2
    small[i]
  end

  def show(ans)
    pp ans
  end
end

Problem.new.instance_eval do
  show(solve)
  # pp self
end
