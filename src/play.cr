io = IO::Memory.new
io.puts "3"
io.puts "10 20 30"
io.close
pp io.gets
pp io.gets