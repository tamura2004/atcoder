require "crystal/st"

t = gets.to_s.to_i64
t.times do
  n, k = gets.to_s.split.map(&.to_i64)
  s = gets.to_s

  m = s.count('1')

  one = s.chars.map { |c| c == '1' ? 1 : 0 }.to_st_sum
  zer = s.chars.map { |c| c == '0' ? 1 : 0 }.to_st_sum

  ans = (0..n-k).count do |i|
    one[i...i+k] == m && zer[i...i+k] == 0
  end

  puts ans == 1 ? :Yes : :No
end

