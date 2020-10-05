def sa(n, s)
  ans = []
  n.times do |i|
    ans << [s[i..-1], i]
  end
  return ans
end

require "minitest/unit"

include Test::Unit::Assertions
assert_equal 1,2
