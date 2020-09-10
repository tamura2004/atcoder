require "listen"

listener = Listen.to("lib/crystal/spec") do |params|
    puts "change detected..."
    Dir.chdir "lib/crystal/spec" do
        puts `crystal spec #{File.basename(params[0])}`
    end
end
puts "watching..."
listener.start
sleep