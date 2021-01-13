# bitDPで部分集合を列挙
#
# ```
# s = 0b101
# each_subset(s) do |ss|
#   printf("%03b\n",b)
# end
#
# # => 101
# # => 100
# # => 001
#
# ```
def each_subset(s)
  b = s
  while b > 0
    yield b
    b -= 1
    b &= s
  end
end
