require "crystal/indexable"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).tally

a.keys.sort.each do |v|
  cnt = 3.times.min_of do |i|
    a[v+i]
  end

  3.times do |i|
    a[v+i] -= cnt
  end
end

puts a.values.sum
