require "colorize"

macro assert(got, want)
  _assert({{got}}, {{want}}, label: "{{got}}")
end

def _assert(got, want, label = "")
  unless got == want
    puts "bad: #{label} got = #{got}, want = #{want}".colorize(:red)
  else
    puts "good: #{label} got = #{got}, want = #{want}".colorize(:green)
  end
end

# require "../lib/crystal/test_helper"
# include Random::Secure
# 100.times do
#   n = rand(1..10)
#   k = rand(1..10)
#   a = Array.new(n) { rand(1..10) }
#   obj = Problem.new(n, k, a)
#   assert obj.solve, obj.solve2
#   if obj.solve != obj.solve2
#     pp! n
#     pp! k
#     pp! a
#   end
# end

# testcase = [
#   {6, 10, [1, 1, 1, 1, 1, 1], 21},
#   {6, 10, [2, 2, 2, 2, 2, 2], 0},
#   {6, 9, [10, 10, 10, 10, 10, 10], 21},
#   {6, 1, [10, 10, 10, 10, 10, 10], 0},
#   {3, 2, [4, 2, 1], 1},
# ]

# testcase.each do |(n, m, a, want)|
#   obj = Problem.new(n, m, a)
#   assert obj.solve, want
#   assert obj.solve2, want
# end
