require "benchmark/ips"
require "prime"

N = 200_000
S = Array.new(N){ (?a..?z).to_a.sample }.join

Benchmark.ips do |x|
  x.report("first") {
    s = "a" << S
  }
  x.report("last") {
    s = S << "a"
  }
  x.compare!
end
