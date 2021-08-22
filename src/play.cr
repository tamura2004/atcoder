require "benchmark"
require "crystal/prime"

Benchmark.ips do |x|
  x.report("convert hash to set") do
    # Prime.prime_factor(510510)
    ans = Hash(Int32,Int32).new(0)
    ans[1] += 1
    ans[2] += 1
    ans[3] += 1
    ans.keys.to_set
  end
  
  x.report("not use set") do
    ans = [] of Int32
    ans << 1
    ans << 2
    ans << 3
  end
  
  x.report("use set only") do
    ans = Set(Int32).new
    ans << 1
    ans << 2
    ans << 3
  end
end