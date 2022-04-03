require "crystal/indexable"

xs = [-9223372036854775808, -3, -2, -1, 1, 2, 4, 9223372036854775807]
pp! xs.upper_bound(0)
pp! xs.lower_bound(3)
# [a, b, c, ai, bi, ci] # => [1, 0, 3, 3, 3, 6]