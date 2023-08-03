require "pathname"

pp "tool"
pp Pathname(__FILE__).expand_path.relative_path_from(Pathname.pwd)