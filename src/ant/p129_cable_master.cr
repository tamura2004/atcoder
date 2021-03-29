require "crystal/problem"
require "crystal/bsearch"

class Main < Problem
  getter n : Int32
  getter k : Int64
  getter a : Array(Float64)

  def initialize(@n, @k, @a)
  end

  def self.read(io : IO)
    n = io.gets.to_s.to_i
    k = io.gets.to_s.to_i64
    a = io.gets.to_s.split.map(&.to_f64)
    new(n, k, a)
  end

  def solve
    # 長さmidのロープを作る時の本数がk以上
    bs = BSearch(Float64).new do |mid|
      k <= a.map(&./ mid).map(&.to_i).sum
    end

    bs.max_of(a.min/k, a.max + 1.0, 300)
  end

  def run
    pp! self
    puts solve
  end
end

Main.read("4\n11\n8.02 7.43 4.57 5.39").run # => 2.0



# # 長さxのロープを作る時の本数
# rope_num = -> (x : Float64) {
#   l.map(&./ x).map(&.to_i).sum
# }

# ans = BSearch(Float64).new(0.0f64, 100.0f64) do |i|
#   k <= rope_num.call(i)
# end

# pp ans.solve.floor(2)

# # 答えを決め打つ二分探索
# class BSearch(T)
#   getter lo : T
#   getter hi : T
#   getter f : Proc(T,Bool) # 条件

#   def initialize(@lo, @hi, &@f : Proc(T,Bool))
#   end

#   # 条件を満たす最大値
#   def solve
#     300.times do
#       mid = (lo + hi) / 2
#       pp! [lo,hi,mid]
#       if f.call(mid)
#         @lo = mid
#       else
#         @hi = mid
#       end
#     end
#     return lo
#   end
# end
