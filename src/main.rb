300.times do |i|
  if i.to_s =~ /(.)\1/
    pp i
  end
end
