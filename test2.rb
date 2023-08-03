require "pathname"

def put_lines(reader)
	reader.each_line do |line|
		puts line
	end
end

put_lines(STDIN)
put_lines(File.open("src/main.cr"))
put_lines(Pathname("src/main.cr"))
