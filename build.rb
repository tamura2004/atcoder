CHMAX = <<EOS.lines
macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

EOS

CHMIN = <<EOS.lines
macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

EOS

MAKE_ARRAY = <<EOS.lines
macro make_array(value, *dims)
  {% for dim in dims %} Array.new({{dim}}) { {% end %}
    {{ value }}
  {% for dim in dims %} } {% end %}
end

EOS

src, target = ARGV
src ||= "src/main.cr"
target ||= "src/target.cr"

seen = Hash.new(false)
buf = File.open(src).readlines

if buf.grep(/chmax/).size > 0 && buf.grep(/macro chmax/).size == 0
  buf = CHMAX + buf
end

if buf.grep(/chmin/).size > 0 && buf.grep(/macro chmin/).size == 0
  buf = CHMIN + buf
end

if buf.grep(/make_array/).size > 0 && buf.grep(/macro make_array/).size == 0
  buf = MAKE_ARRAY + buf
end

flag = true
while flag
  flag = false
  tmp = []
  buf.each do |line|
    if line =~ /^require "crystal\/(.*)"/
      name = $1
      next if seen[name]
      seen[name] = true
      tmp << "\n"
      tmp << "# " + line
      tmp += File.open("lib/crystal/#{name}.cr").readlines
      tmp << "\n"
      flag = true
    else
      tmp << line
    end
  end
  buf = tmp
end

File.open(target, "w").write(buf.join)
