require "string_scanner"

t = gets.to_s
s = t.chars
u = t.chars
t.size.times do |i|
  if t[i] == '?'
    if i.odd?
      s[i] = '2'
      u[i] = '5'
    else
      s[i] = '5'
      u[i] = '2'
    end
  end
end

s = s.join
u = u.join

puts Math.max(num(s), num(u))

def num(s)
  return 0 unless s.match(/25/)
  s.scan(/(25)+/).max_of do |md|
    md[0]? ? md[0].size : 0
  end
end