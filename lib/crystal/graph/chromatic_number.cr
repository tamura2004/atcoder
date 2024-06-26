# require "crystal/graph/i_bit_graph"

# class ChromaticNumber

#   MOD = 10_i64 ** 9 + 7
#   getter g : IBitGraph
#   getter ind : Array(Int64) # 独立集合
#   getter aux : Array(Int64)
#   delegate n, to: g

#   def initialize(@g)
#     @ind = Array.new(1 << n, 0_i64)
#     ind[0] = 1_i64
#     @aux = Array.new(1 << n) { |s| sign(s) }
#   end

#   # 包除原理計算用符号
#   def sign(s)
#     -1_i64 ** ((s.popcount ^ n) & 1)
#   end

#   def solve
#     # bit DP
#     n.each_subset do |s|
#       next if s.zero?
#       t = s.trailing_zeros_count
#       ind[s] = ind[s.off(t)] + ind[s.off(t) & ~g.mask(t)]
#     end

#     # 畳み込み
#     (1...n).each do |k|
#       sum = 0_i64
#       n.each_subset do |s|
#         aux[s] = (aux[s] * ind[s]) % MOD
#         sum += aux[s]
#       end
#       return k if sum % MOD != 0
#     end

#     return n
#   end
# end
