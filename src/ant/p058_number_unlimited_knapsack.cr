require "crystal/knapsack_number_unlimited"

pp Knapsack::NumberUnlimited.read(<<-EOS
  3 7
  3 4 2
  4 5 3
  EOS
).solve # => 10
