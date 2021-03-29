require "crystal/knapsack_weight_limited"

pp Knapsack::WeightLimited.read(<<-EOS
  4 5
  2 1 3 2
  3 2 4 2
  EOS
).solve # => 7
