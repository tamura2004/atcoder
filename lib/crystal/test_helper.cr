require "colorize"
require "./test_tree"

module Test
  def assert(got, want)
    color = got == want ? :green : :red
    color.tap do |c|
      puts "got = #{got}, want = #{want}".colorize(c)
    end
  end

  def assert(obj, got, want)
    if assert(got, want) == :red
      puts ("bad:" + obj.pretty_inspect + "\n----").colorize(:red)
    end
  end

  def assert(got, want, &block)
    assert(yield, got, want) == :red
  end
end

# require "../lib/crystal/test_helper"
# include Random::Secure

# 10.times do
#   n = rand(10)
#   m = 1000_i64
#   a = Array.new(n) { rand(m) + 1 }
#   obj = Problem.new(n, a)
#   assert obj.solve, obj.solve2 do
#     {n, a}
#   end
# end

# testcase = [
#   {4, [2, 3, 4, 5], 14},
#   {5, [1, 2, 3, 4, 5], 15},
# ]

# testcase.each do |(n, a, want)|
#   obj = Problem.new(n, a.map &.to_i64)
#   assert obj.solve, obj.solve2 do
#     {n, a}
#   end
# end
