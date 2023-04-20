require "crystal/multiset"
require "crystal/orderedset"

n = gets.to_s.to_i64
q = gets.to_s.to_i64

box = Array.new(200_001) do
  Multiset(Int32).new
end

card = Array.new(200_001) do
  OrderedSet(Int32).new
end

q.times do
  cmd, i, j = gets.to_s.split.map(&.to_i) + [0]
  case cmd
  when 1
    box[j] << i
    card[i] << j
  when 2
    puts box[i].to_a.join(" ")
  when 3
    puts card[i].to_a.join(" ")
  end
end

