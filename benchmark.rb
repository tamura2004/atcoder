require "benchmark"

N = 10_000_000

class A
    attr_accessor :a
    def initialize(a)
        @a = a
    end
    def double
        a*2
    end
end

B = Struct.new(:a) do
    def double
        a*2
    end
end

Benchmark.bm 10 do |r|
    r.report "library" do
        s = 0
        N.times do
            a = A.new(N)
            s += a.double
        end
    end
    r.report "library" do
        s = 0
        N.times do
            a = B.new(N)
            s += a.double
        end
    end
end
