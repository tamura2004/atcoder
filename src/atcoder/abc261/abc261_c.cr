n = gets.to_s.to_i64
dic = Hash(String,Int32).new(0)

n.times do
  s = gets.to_s
  if dic[s].zero?
    puts s
  else
    puts "#{s}(#{dic[s]})"
  end
  dic[s] += 1
end

