a = [1, 5, 3, 6, 4]
max = a.max
pp a.each_index.max_by { |i| a[i] }
