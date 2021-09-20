module Arc126
  module C
    class Cs
      getter n : Int32
      getter m : Int64
      getter sum : Int64
      getter a : Array(Int64)
      getter cs : Array(Int64)
    
      def initialize(a)
        @a = a.map(&.to_i64)
        @sum = @a.sum
        @n = @a.size
        @m = @a.max
        @cs = Array.new(m + 1, 0_i64)
        rec
      end
    
      def rec
        a.each do |i|
          cs[i] += 1
        end
    
        m.times do |i|
          cs[i+1] += cs[i]
        end
      end
    
      def [](r : Range(Int32,Int32))
        lo = r.begin
        hi = Math.min r.end, m
        cs[hi] - cs[lo]
      end
    
      def cost(x)
        x.step(by: x, to: m + x).sum do |i|
          self[i-x..i] * i
        end - sum
      end
    end
  end
end

# require "crystal/arc126/c/cs"
# include Arc126::C

# n, k = gets.to_s.split.map(&.to_i64)
# a = gets.to_s.split.map(&.to_i64)
# cs = Cs.new(a)

# if cs.sum <= k
#   puts (cs.sum + k) // n
#   exit
# end

# costs = Array.new(cs.m+1, 0_i64)
# 1.upto(cs.m) do |i|
#   costs[i] = cs.cost(i)
# end

# cs.m.downto(1) do |i|
#   if costs[i] <= k
#     puts i
#     exit
#   end
# end
