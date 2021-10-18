a = [1, 5, 3, 6, 4]
a.zip(0..).reverse_each do |v,i|
  pp [v,i]
end


