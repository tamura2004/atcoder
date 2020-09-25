require "colorize"

# require "./test_tree"

macro assert!(exp, want, &block)
  begin
    _assert {{exp}}, {{want}}, "{{exp}}", "{{want}}" do
      {{block.body}}
    end
  rescue e
    error e.message.not_nil!
    trace = e.backtrace.select do |s|
      s =~ /src\/main.cr|dist\/tmp.cr/
    end
    error trace.join("\n")
    newline
    {{block.body}}
    exit
  end
end

def _assert(got, want, gotlabel, wantlabel, &block)
  color = got == want ? :green : :red
  color.tap do |c|
    puts "#{gotlabel} = #{got}, #{wantlabel} = #{want}".colorize(c)
    yield if c == :red
  end
end

macro error!(obj)
  unless obj.nil?
    error("{{obj}} = " + {{obj}}.pretty_inspect)
  end
end

macro warning!(obj)
  unless obj.nil?
    warning("{{obj}} = " + {{obj}}.pretty_inspect)
  end
end

macro success!(obj)
  unless obj.nil?
    success("{{obj}} = " + {{obj}}.pretty_inspect)
  end
end

def error(msg : String)
  STDERR.puts msg.colorize(:red)
end

def warning(msg : String)
  STDERR.puts msg.colorize(:yellow)
end

def success(msg : String)
  STDERR.puts msg.colorize(:green)
end

def newline
  STDERR.puts
end

# require "../lib/crystal/test_helper"
# include Random::Secure

# 10.times do
#   n = rand(10)
#   m = 1000_i64
#   a = Array.new(n) { rand(m) + 1 }
#   msg = Problem.new(n, a)
#   assert obj.solve, obj.solve2 do
#     {n, a}
#   end
# end

# testcase = [
#   {4, [2, 3, 4, 5], 14},
#   {5, [1, 2, 3, 4, 5], 15},
# ]

# testcase.each do |(n, a, want)|
#   obj = Problem.new(n, a.map &.to_i64)
#   assert obj.solve, obj.solve2 do
#     {n, a}
#   end
# end
