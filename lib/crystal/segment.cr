class Segment(T)
  getter a : Int64
  getter b : Int64
  getter values : Array(T)

  def initialize(@a : Int64, @b : Int64)
    @values = Array(T).new(b - a) { |i| yield a + i }
  end

  def [](i)
    check_error(i)
    @values[i - a]
  end

  def []=(i, j)
    check_error(i)
    @values[i - a] = j
  end

  def check_error(i)
    raise "index must be in range: #{a} <= #{i} < #{b}" if i < a || b <= i
  end

  def each_measure_index(i)
    j = (a + i - 1) // i * i
    j.step(to: b - 1, by: i) do |k|
      yield k
    end
  end

  forward_missing_to @values
end

# require "spec"
# a = 10_i64
# b = 20_i64
# s = Segment(Int64).new(a,b) { |i| i * 2 }
# s[15].should eq 30
# ans = [] of Int64
# s.each_measure_index(3) do |i|
#   ans << i
# end
# ans.should eq [12,15,18]
