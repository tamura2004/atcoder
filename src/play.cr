require "crystal/multiset"

n = gets.to_s.to_i
ms = gets.to_s.split.map(&.to_i64).to_multiset

m = gets.to_s.to_i
gets.to_s.split.map(&.to_i64).each do |t|
  if !ms.includes?(t)
    puts "NO"
    exit
  end
  ms.delete t
end

puts "YES"

