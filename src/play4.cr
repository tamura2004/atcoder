require "benchmark"

Benchmark.ips do |x|
  # x.report("128 <<") { 1_u128 << 127 }
  # x.report("64 <<") { 1_u64 << 63}
  x.report("128 ^") { 1_u128 ^ (1_u128 << 127) }
  x.report("64 ^") { 1_u64 ^ (1_u64 << 63) }
end
