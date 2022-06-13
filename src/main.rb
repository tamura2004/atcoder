require "pathname"

path = "hoge/fuga/moga"

pp Pathname.new(path).dirname + Pathname.new(path).basename
