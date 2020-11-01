14.upto(124) do |i|
  u = (i*8).to_s.chars.map(&.to_i)
  next false if u.includes?(0)

  pp u
  pp u.tally
  # u.chars.map(&.to_i).tally.all? do |k,v|
  #   cnt[k] >= v
  # end
end

