require "benchmark/ips"
require "numo/narray"

N = 100
INF = 1<<60

Benchmark.ips do |x|
  x.report("wf") do
    g = Array.new(N){ Array.new(N, INF) }
    N.times { |i| g[i][i] = 0 }
    N.times do
      (0..N).to_a.sample(3) do |x,y,z|
        g[x][y] = z
        g[y][x] = z
      end
    end
    N.times do |k|
      N.times do |i|
        N.times do |j|
          len = g[i][k] + g[k][j]
          g[i][j] = len if len < g[i][j]
        end
      end
    end
  end
  x.report("numo") do
    g = Numo::Int64.new(N,N).fill(INF)
    N.times { |i| g[i,i] = 0 }
    N.times do
      (0..N).to_a.sample(3) do |x,y,z|
        g[x,y] = z
        g[y,x] = z
      end
    end
    N.times do |k|
      N.times do |i|
        N.times do |j|
          len = g[i,k] + g[k,j]
          g[i,j] = len if len < g[i,j]
        end
      end
    end

  end
end
