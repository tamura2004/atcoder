require "benchmark"
require "big"
require "bit_array"
require "crystal/tree"

N = 100000

Benchmark.ips do |x|
  x.report("uni remove") do
    g = Tree.make(N, :uni)
    g.remove(0)
  end

end
