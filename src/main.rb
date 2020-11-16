require "benchmark/ips"

N = 100
A = Array.new(N){ Array.new(N){ Array.new(N, 0) } }

Benchmark.ips do |r|
  r.report("ruby") {
    N.times do |k|
      N.times do |j|
        N.times do |i|
          A[i][j][k] += 1
        end
      end
    end
  }
end