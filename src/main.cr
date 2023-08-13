n = 1000
h = Hash(Int32, Int32).new
n.times do
  h[rand(Int32::MAX)] = rand(Int32::MAX)
end

pp h.keys.sort.first
pp h.first_key
