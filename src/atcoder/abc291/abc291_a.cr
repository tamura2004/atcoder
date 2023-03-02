s = gets.to_s
ans = -1
('A'..'Z').each do |c|
  if i = s.index(c)
    ans = i
  end
end

pp ans + 1
