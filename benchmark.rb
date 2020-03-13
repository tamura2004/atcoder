require "benchmark/ips"
require "prime"

N = 200_000
S = Array.new(N){ 0 }

Benchmark.ips do |x|
  x.report("first") {
    S[0] += 1
    ans = S[0]
  }
  x.report("last") {
    S[-1] += 1
    ans = S[-1]
  }
  x.compare!
end
