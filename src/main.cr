10.times do |i|
  ->{
    return if i > 5
    pp i
  }.call
end
