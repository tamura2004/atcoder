require "json"

class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)

  def initialize
    @s = gets.chomp
    @a = JSON.parse(s, symbolize_names: true).select{|h|h[:result] == "AC"}
    a.sort_by!{|h|h[:epoch_second]}
  end

  def solve
    a.each_cons(2).with_object([]) do |(b,c),ans|
      sec = c[:epoch_second] - b[:epoch_second]
      next if 24 * 3600 < sec
      ans << [sec / 60, c[:problem_id]].join(",")
    end
  end

  def show(ans)
    puts ans
  end
end

Problem.new.instance_eval do
  show(solve)
  open("nakazato.txt","w") do |fh|
    fh.puts solve
  end
end
