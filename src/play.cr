cnt = 10.times.with_object([] of Int32) do |i, dp|
  dp << i * 2
end

pp cnt
