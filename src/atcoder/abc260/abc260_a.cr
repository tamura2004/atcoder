s = gets.to_s.chars.tally
s.each do |k,v|
  quit k if v == 1
end
pp -1
  