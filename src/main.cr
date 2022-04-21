s1 = gets.to_s
s2 = gets.to_s
s3 = gets.to_s

words = [s1,s2,s3].map(&.chars).flatten.uniq.sort.join
n = words.size

(0..9).to_a.each_permutation(n) do |a|
  nums = a.join
  n1 = s1.tr(words,nums)
  n2 = s2.tr(words,nums)
  n3 = s3.tr(words,nums)

  next if n1[0] == '0'
  next if n2[0] == '0'
  next if n3[0] == '0'

  next unless n1.to_i64 + n2.to_i64 == n3.to_i64
  puts n1
  puts n2
  puts n3
  exit
end

puts "UNSOLVABLE"
