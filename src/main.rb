open("tmp.txt","w") do |fh|
  while line = gets
    fh.puts '"' + line.chomp + '",'
  end
end