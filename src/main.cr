require "benchmark"

N = 200
INF = 1<<60

Benchmark.ips do |x|
  x.report("wf") do
    g = Array.new(N){ Array.new(N, INF) }
    N.times { |i| g[i][i] = 0 }
    N.times do |k|
      N.times do |i|
        N.times do |j|
          len = g[i][k] + g[k][j]
          g[i][j] = len if len < g[i][j]
        end
      end
    end
  end
end
