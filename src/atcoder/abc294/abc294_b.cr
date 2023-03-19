h,w = gets.to_s.split.map(&.to_i64)
h.times do
  a = gets.to_s.split.map(&.to_i64)
  ans = a.map do |i|
    if i.zero?
      '.'
    else
      ('A'.ord + i - 1).chr
    end
  end
  puts ans.join
end
