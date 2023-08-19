E = 1u64
candi = (0...60).to_a.combinations(3).map do |a|
  a.sum { |i| E << i }
end.sort.reverse

t = gets.to_s.to_u64
t.times do
  n = gets.to_s.to_u64
  if n < 7
    pp -1
  else
    ans = candi.bsearch(&.<= n)
    pp ans
  end
end
