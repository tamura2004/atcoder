n = gets.to_s.to_i64
(n..999).each do |m|
  a,b,c = m.digits
  if a == b * c
    quit m
  end
end


