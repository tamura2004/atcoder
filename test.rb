require "pathname"
require "stringio"
require_relative "tool/code_runner"

code_runner = CodeRunner.new
code_runner.lang = "ruby"
code_runner.extname = ".rb"

input_io = StringIO.new("require \"crystal/graph\"")
output_io = StringIO.new

code_runner.bundle(input_io, output_io)
pp output_io.string
pp code_runner.lang
pp code_runner.extname
pp code_runner.bundler
