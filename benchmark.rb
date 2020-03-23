require "benchmark/ips"
require "prime"

N = 200_000
S = Array.new(N){ (?a..?z).to_a.sample }

Benchmark.ips do |x|
  x.report("first") {
    a = S.first
  }
  x.report("last") {
    a = S.last
  }
  x.compare!
end
