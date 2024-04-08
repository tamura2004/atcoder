a, b = gets.to_s.split.map(&.to_i64)
(0..9).each do |c|
  if a + b != c
    quit c
  end
end
