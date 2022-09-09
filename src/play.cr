require "big"
require "benchmark"

N = 10000

def bigint
  ranges = Array.new(N) do
    (0...N).to_a.sample(2).minmax
  end
  bint = 0.to_big_i
  ranges.each do |lo, hi|
    bint |= (1.to_big_i << hi - lo) - 1 << lo
  end

  puts N - bint.popcount
end

bigint
