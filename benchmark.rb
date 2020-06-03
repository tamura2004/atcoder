require "benchmark/ips"
require "prime"

N = 100000
A = Array.new(N){ rand 1..1000000 }
B = Array.new(N){ rand 1..1000000 }

Benchmark.ips do |x|
  x.report("dup") {
    a = Array.new(500){ (?a..?z).to_a.sample }
    b = Array.new(500){ (?a..?z).to_a.sample }
    c = (a - b).first
  }
  x.compare!
end
