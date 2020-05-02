require "benchmark/ips"
require "prime"

N = 200_000
S = Array.new(N){ (?0..?9).to_a.sample }.join
A = Array.new(N){ rand(10) }

Benchmark.ips do |x|
  x.report("string") {
    ix = S.index("5",N/2)
  }
  x.report("number") {
    ix = A.index(5)
  }
  x.compare!
end
