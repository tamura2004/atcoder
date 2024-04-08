n = gets.to_s.to_i64
s = gets.to_s.chars
dic = ('a'..'z').to_a.map{|c| {c, c}}.to_h


q = gets.to_s.to_i64
q.times do
  c, d = gets.to_s.split.map(&.[0])
  dic.transform_values! do |v|
    v == c ? d : v
  end
end

ans = s.map{|c| dic[c]}.join
pp! dic

puts ans