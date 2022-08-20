# min_max法
# メモ化再帰版

class Problem
  getter h : Int32
  getter w : Int32
  getter a : Array(Array(Int64))
  getter memo : Array(Array(Int64)) # メモ

  def initialize(@h, @w, @a)
    @memo = make_array(-1_i64, h, w)
    @memo[-1][-1] = 0_i64
  end

  def f(y, x)
    return memo[y][x] if memo[y][x] != -1_i64
    
    sign = (y + x).even? ? 1 : -1 # taka = 1, aoki = -1
    gain = Int64::MIN
    
    [{1, 0}, {0, 1}].each do |dy, dx|
      yy = y + dy
      xx = x + dx
      next if yy == h || xx == w
      chmax gain, f(yy, xx) * sign + a[yy][xx]
    end
    
    memo[y][x] = gain * sign
  end

  def solve
    %w(Draw Takahashi Aoki)[f(0, 0).sign]
  end
end

h, w = gets.to_s.split.map(&.to_i)
a = Array.new(h) do
  gets.to_s.chars.map { |c| c == '+' ? 1 : -1 }.map(&.to_i64)
end

pr = Problem.new(h, w, a)
ans = pr.solve
puts ans
