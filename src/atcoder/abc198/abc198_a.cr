s1 = gets.to_s
s2 = gets.to_s
s3 = gets.to_s

words = [s1,s2,s3].map(&.chars).flatten.uniq.join
n = words.size

quit "UNSOLVABLE" if n > 10

('0'..'9').to_a.each_permutation(n) do |pat|
  pat = pat.join
  n1 = s1.tr(words, pat)
  n2 = s2.tr(words, pat)
  n3 = s3.tr(words, pat)

  next if n1 =~ /^0/
  next if n2 =~ /^0/
  next if n3 =~ /^0/
  
  next if n1.to_i64 + n2.to_i64 != n3.to_i64
  
  puts n1
  puts n2
  puts n3
  exit
end

quit "UNSOLVABLE"


