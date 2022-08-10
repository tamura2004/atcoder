ans = 4.times.count do
  gets.to_s.chars.all?(&.== '1')
end
pp ans