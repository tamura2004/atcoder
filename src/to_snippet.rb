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

  def initialize
  end

  {% if env("DEBUG") %}
    def initialize
    end
  {% end %}

  def solve
  end

  def run
    puts solve
  end
end

Problem.new.run

{% if env("DEBUG") %}
  pp! Problem.new
  # 100.times do
  #   n = rand(1..10)
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
{% end %}
