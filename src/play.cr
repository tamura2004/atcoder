a = [1,2,3]
ans = a.any? do |i|
  return false if i == 0
  return false if i == 1
  return false if i == 2
  true
end

pp! ans