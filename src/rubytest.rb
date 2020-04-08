require "tomlrb"

good = true
cases = Tomlrb.load_file("testcase.toml", symbolize_keys: true)

cases[:testcase].each do |k,v|
    io = IO.popen("ruby src/main.rb", "w+")
    io.puts k
    io.close_write
    ans = io.read.chomp

    if ans != v
        puts "bad #{k}. want:#{v}, got:#{ans}"
    else
        puts "good #{k}. want:#{v}, got:#{ans}"
    end
end

