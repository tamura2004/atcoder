require "pathname"

Pathname.new("lib/crystal").find do |path|
  next unless path.file?
  next unless path.to_s =~ /spec/
  lines = path.readlines
  lines.map! do |line|
    line.gsub! /require \"crystal\/\//, "require \"crystal\/"
    line.gsub! /require \"\.\./, "require \"crystal"
    line
  end
  path.open("w") do |fh|
    fh.write lines.join
  end
  # exit
end
