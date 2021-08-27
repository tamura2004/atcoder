require "readline"

while line = Readline.readline("test> ", true)
  begin
    puts line
  rescue e
    puts e.message
  end
end