N = 1000
open("sample.txt", "w") do |f|
  f.puts "1000 1000"
  f.puts "1000 1000"
  f.puts "1 1"
  N.times do |i|
    if i.even?
      f.puts ".#" * 500
    else
      f.puts "#." * 500
    end
  end
end
