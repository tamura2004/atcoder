open "snippet.txt", "w" do |fh| 
  DATA.each_line do |line|
    fh.puts line.chomp.inspect + ","
  end
end
__END__
{% if env("DEBUG") %}
  require "debug"
  require "../lib/crystal/test_helper"
  include Random::Secure
{% else %}
  macro debug!(content)
  end
{% end %}

class Problem
  getter n : Int32
  getter a : Array(Int64)

  def initialize(@n, @a)
  end

  def self.read
    n = gets.to_s.to_i
    a = gets.to_s.split.map { |v| v.to_i64 }
    new(n, a)
  end

  def solve
    42
  end

  def solve2
    a.sum
  end

  def run
    puts solve
  end
end

Problem.read.run

10.times do
  n = rand(10)
  m = 1000_i64
  a = Array.new(n) { rand(m) + 1 }
  obj = Problem.new(n, a)
  assert obj.solve, obj.solve2 do
    {n, a}
  end
end

testcase = [
  {4, [2, 3, 4, 5], 14},
  {5, [1, 2, 3, 4, 5], 15},
]

testcase.each do |(n, a, want)|
  obj = Problem.new(n, a.map &.to_i64)
  assert obj.solve, obj.solve2 do
    {n, a}
  end
end
