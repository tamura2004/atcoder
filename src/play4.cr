require "benchmark"

A = (0...100_000).to_a
H = Hash(Int32, Int32).new
100_000.times do |i|
  H[i] = i
end

Benchmark.ips do |bm|
  bm.report("hash") do
    j = H[50_000]
  end

  bm.report("bsearch") do
    j = A.bsearch_index(&.>= 50_000)
  end
end
