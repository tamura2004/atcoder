want = 7 ** 3

100.times do |i|
  got = i ** 0 + i ** 1 + i ** 2
  if got == want
    quit i
  end
end
