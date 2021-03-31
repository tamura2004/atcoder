k = gets.to_s.to_i

cnt = 1.upto(1000000).map do |i|
  (k * i).to_s.chars.map(&:to_i).sum
end.tally

pp cnt
