c = 10
d = 4

(0..10).each do |t|
  pp [t, c + d / (t + 1) + t]
end
