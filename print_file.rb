require_relative "tool/print_file"
require "pathname"

pp "main"
pp Pathname.pwd
pp Pathname(__FILE__).expand_path.relative_path_from(Pathname.pwd)