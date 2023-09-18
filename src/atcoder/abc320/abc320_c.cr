require "crystal/nex"

n = gets.to_s.to_i
slots = Array.new(3) do
  Nex.new gets.to_s.chars.map(&.to_i), 3
end

[*0...3].each_permutation.min_of do |ord|
  10.times.min_of do |i|
    ord.reduce(-1) do |acc, b|
      acc.try { |j| slots[b][i, j + 1] }
    end || Int32::MAX
  end
end.try do |ans|
  pp ans == Int32::MAX ? -1 : ans
end
