require "listen"

listener = Listen.to("src") do
    puts "main.rb changed!"
    STDOUT.flush
end
listener.start
sleep