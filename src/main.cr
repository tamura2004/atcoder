s = gets.to_s.chomp.gsub(/\s/,"")
t = "0123456789"
n = gets.to_s.to_i64
a = Array.new(n) do
  i = gets.to_s.tr(s,t).to_i
end
a.sort!
a.each do |i|
  puts i.to_s.tr(t,s)
end
