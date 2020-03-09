require "benchmark/ips"
require "prime"

N = 200_000
S = (?0..?9).to_a.sample(N).join

Benchmark.ips do |x|
  x.report("binary_search") {
    ans = S[100_000].ord - 48
  }
  x.report("bsearch") {
    s = S.split(//).map &:to_i
    ans = S[100_000]
  }
  x.compare!
end
