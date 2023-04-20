require "benchmark"
require "crystal/btrie"
require "crystal/balanced_tree/treap/multiset"

Benchmark.ips do |bm|
  bm.report("btrie") do
    tr = BTrie.new(multi: true)
  end

  bm.report("multiset") do
    tr = Multiset(Int32).new
  end
end
