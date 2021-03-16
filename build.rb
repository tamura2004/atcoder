require "pathname"

File.open("src/main.cr") do |inFile|
  File.open("src/target.cr", "w") do |outFile|
    inFile.each_line do |line|
      if line =~ /require "(.*)"/
        File.open("lib/#{$1}.cr") do |insFile|
          outFile.write(insFile.read)
        end
      else
        outFile.puts line
      end
    end
  end
end
