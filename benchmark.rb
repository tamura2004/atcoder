require "benchmark/ips"
require "prime"

def f; Array.new(100000){rand(1000000000)}; end

Benchmark.ips do |x|
  x.report("/=16") {
    a = 100
    a /= 16
  }
  x.report(">>=4") {
    a = 100
    a >>= 4
  }
  x.compare!
end
