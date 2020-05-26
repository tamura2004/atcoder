require "benchmark/ips"
require "prime"

N = 100000
A = Array.new(N){ rand 1..1000000 }
B = Array.new(N){ rand 1..1000000 }

Benchmark.ips do |x|
  x.report("bit") {
    N.times do |i|
      x = (A[i]<<32) | B[i]
      y = x >> 32
      z = x & ((1<<32)-1)
    end
  }
  x.report("decimal") {
    N.times do |i|
      x = A[i] * 10000000 + B[i]
      y = x / 10000000
      z = x % 10000000
    end
  }
  x.compare!
end
