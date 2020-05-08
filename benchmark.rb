require "benchmark/ips"
require "prime"

N = 100
S = Array.new(N){ (?0..?9).to_a.sample }.join
A = Array.new(N){ rand(10) }

Benchmark.ips do |x|
  x.report("shift") {
    y = 1 << N
  }
  x.report("power") {
    y = 2 ** N
  }
  x.compare!
end
