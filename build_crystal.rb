require "pathname"
require "set"

MACROS = {
  "chmax" => <<~EOS.lines,
    macro chmax(target, other)
      {{target}} = ({{other}}) if ({{target}}) < ({{other}})
    end

  EOS
  "chmin" => <<~EOS.lines,
    macro chmin(target, other)
      {{target}} = ({{other}}) if ({{target}}) > ({{other}})
    end

  EOS
  "make_array" => <<~EOS.lines,
    macro make_array(value, *dims)
      {% for dim in dims %} Array.new({{dim}}) { {% end %}
        {{ value }}
      {% for dim in dims %} } {% end %}
    end

  EOS
  "quit" => <<~EOS.lines,
    macro quit(msg)
      puts({{msg}}) + exit
    end

  EOS
  "divceil" => <<~EOS.lines,
    macro divceil(a, b)
      ((({{a}}) + ({{b}}) - 1) // ({{b}}))
    end

  EOS
}

class Bundler
  attr_accessor :src, :target, :buf_head, :buf_body, :lib_seen, :macro_keys, :macro_seen, :lib_base

  def initialize
    @buf_head = []
    @buf_body = []
    @lib_seen = Set.new
    @macro_seen = Set.new
    @macro_keys = MACROS.keys
    @lib_base = Pathname("lib/crystal")
  end

  def run
    dfs(STDIN)
    macro_seen.each do |key|
      @buf_head += MACROS[key]
    end
    puts buf_head + buf_body
  end

  def dfs(reader)
    reader.each_line do |line|
      if line =~ /^require "crystal\/(.*)/
        buf_body << "# #{line}\n"
        new_reader = find_path(line)
        next if lib_seen.include?(new_reader.to_s)
        lib_seen << new_reader.to_s
        dfs(new_reader)
      else
        buf_body << line
        macro_keys.select { line.include?(_1) }.each { macro_seen << _1 }
      end
    end
  end

  private

  def get_lib_name(line)
    line.scan(/^require \"crystal\/(.*)\"$/)&.first&.first
  end

  def find_path(line)
    lib_name = get_lib_name(line)
    return Pathname(line) if lib_name.nil?
    path = lib_base + lib_name
    return path.sub_ext(".cr") if path.sub_ext(".cr").exist?
    path + path.basename.sub_ext(".cr")
  end
end

Bundler.new.run
