require "pathname"

Pathname.new("/home/tamura").find do |path|
    next unless path.file?
    next unless path.to_s =~ /0630/

    pp path
end
