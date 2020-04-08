# require "pathname"

# Pathname.new(".").find do |path|
#     puts path
# end
# __END__


cases = {
  [10,3] => 9,
  [3,10] => 7,
  [0,10] => 10,
  [-3,10] => 8,
  [-10,3] => 8,
  [-10,0] => 10,
  [-10,-3] => 7,
  [-3,-10] => 9,
  [0,-10] => 11,
  [3,-10] => 8,
  [10,-10] => 1,
  [10,-3] => 8,
  [10,0] => 11
}

cases.each do |k,v|
    io = IO.popen("ruby src/main.rb", "w+")
    io.puts k.join(" ")
    io.close_write
    ans = io.read.to_i
    next if ans == v

    puts "bad #{k}. want:#{v}, got:#{ans}"
end
