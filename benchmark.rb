require "benchmark/ips"
require "prime"

N = 200_000
S = (?0..?9).to_a.sample(N).join

Benchmark.ips do |x|
  x.report("string hash") {
    ans = "123456789".hash
  }
  x.report("array hash") {
    ans = "123456789".to_sym.hash
  }
  x.compare!
end
